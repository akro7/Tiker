#!/usr/bin/env python3
"""
AGOU Patch Script v3.0
@author @A_KOJO / AKRO
"""
import os, sys, re, shutil, argparse

R="\033[0;31m"; G="\033[0;32m"; C="\033[0;36m"; Y="\033[1;33m"; N="\033[0m"

def log_ok(m):   print(f"{G}  ✓ {m}{N}")
def log_warn(m): print(f"{Y}  ⚠ {m}{N}")
def log_step(n,m): print(f"\n{Y}[{n}] {m}{N}")

def read(p):
    with open(p,"r",encoding="utf-8",errors="ignore") as f: return f.read()

def write(p,c):
    with open(p,"w",encoding="utf-8") as f: f.write(c)

def sub(path, pattern, repl, label):
    if not os.path.isfile(path): log_warn(f"Not found: {path}"); return
    src = read(path)
    new,n = re.subn(pattern, repl, src)
    if n: write(path,new); log_ok(label)
    else: log_warn(f"Pattern not found: {label}")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--tg-dir",   required=True)
    ap.add_argument("--api-id",   required=True)
    ap.add_argument("--api-hash", required=True)
    args = ap.parse_args()

    tg       = os.path.abspath(args.tg_dir)
    api_id   = args.api_id.strip()
    api_hash = args.api_hash.strip()

    print(f"{C}  AGOU Patch Script v3.0 — @A_KOJO / AKRO{N}\n")

    tmsgs  = os.path.join(tg,"TMessagesProj")
    main_  = os.path.join(tmsgs,"src","main")
    java_  = os.path.join(main_,"java")
    org_tg = os.path.join(java_,"org","telegram")

    # ── 1. API Keys ────────────────────────────────────────────────────────────
    log_step("1/8","API Keys → BuildVars.java")
    bv = os.path.join(org_tg,"messenger","BuildVars.java")
    sub(bv, r'(public static int APP_ID\s*=\s*)\d+(\s*;)',
        rf'\g<1>{api_id}\2', "APP_ID")
    sub(bv, r'(public static String APP_HASH\s*=\s*")[^"]*(")',
        rf'\g<1>{api_hash}\2', "APP_HASH")

    # ── 2. App name ────────────────────────────────────────────────────────────
    log_step("2/8","App name → AGOU")

    # strings.xml — كل الطرق الممكنة
    sx = os.path.join(main_,"res","values","strings.xml")
    if os.path.isfile(sx):
        src = read(sx)
        # طريقة 1: name="app_name"
        new,n = re.subn(r'(<string name="app_name"[^>]*>)[^<]*(</string>)',
                        r'\g<1>AGOU\2', src)
        if n: write(sx,new); log_ok("strings.xml app_name")
        else:
            # طريقة 2: أول <string> يحتوي على Telegram
            new,n = re.subn(r'(<string[^>]*>)Telegram(</string>)',
                            r'\g<1>AGOU\2', src)
            if n: write(sx,new); log_ok("strings.xml Telegram→AGOU")
            else: log_warn("strings.xml — not found, injecting manually")
            # طريقة 3: inject في أول السطر
            if n == 0:
                src = src.replace('<resources>',
                    '<resources>\n    <string name="app_name">AGOU</string>', 1)
                write(sx,src); log_ok("strings.xml injected")

    # ApplicationLoader
    al = os.path.join(org_tg,"messenger","ApplicationLoader.java")
    sub(al, r'(applicationName\s*=\s*")[^"]*(")', r'\g<1>AGOU\2',
        "ApplicationLoader.applicationName")

    # ── 3. applicationId ───────────────────────────────────────────────────────
    log_step("3/8","applicationId → agou.eko.telegram")
    bg = os.path.join(tmsgs,"build.gradle")
    sub(bg, r'(applicationId\s*["\'])org\.telegram\.messenger(["\'])',
        r'\g<1>agou.eko.telegram\2', "build.gradle applicationId")
    sub(bg, r'(namespace\s*["\'])org\.telegram\.messenger(["\'])',
        r'\g<1>agou.eko.telegram\2', "build.gradle namespace")

    # ── 4. AndroidManifest ────────────────────────────────────────────────────
    log_step("4/8","AndroidManifest patches")
    mf = os.path.join(main_,"AndroidManifest.xml")
    sub(mf, r'org\.telegram\.messenger', 'agou.eko.telegram', "Manifest all refs")

    # ── 5. AGOU Java sources ───────────────────────────────────────────────────
    log_step("5/8","Copy AGOU Java sources")
    agou_dir = os.path.dirname(os.path.abspath(__file__))
    src_java = os.path.join(agou_dir,"TMessagesProj","src","main","java","agou")
    dst_java = os.path.join(java_,"agou")
    if os.path.isdir(src_java):
        if os.path.exists(dst_java): shutil.rmtree(dst_java)
        shutil.copytree(src_java, dst_java)
        log_ok("AGOU Java → TelegramSource")
    else: log_warn("AGOU Java not found")

    # ── 6. AGOU res (icons + strings override) ────────────────────────────────
    log_step("6/8","Copy AGOU res (icons, strings)")
    src_res = os.path.join(agou_dir,"TMessagesProj","src","main","res")
    dst_res = os.path.join(main_,"res")
    if os.path.isdir(src_res):
        for root,dirs,files in os.walk(src_res):
            rel = os.path.relpath(root, src_res)
            d   = os.path.join(dst_res, rel)
            os.makedirs(d, exist_ok=True)
            for f in files:
                shutil.copy2(os.path.join(root,f), os.path.join(d,f))
        log_ok("AGOU res → TelegramSource")

    # ── 7. AgouConfig.init() inject ───────────────────────────────────────────
    log_step("7/8","Inject AgouConfig.init()")
    if os.path.isfile(al):
        src = read(al)
        imp = "import agou.eko.telegram.AgouConfig;"
        ini = "        AgouConfig.init(this);"
        if imp not in src:
            src = src.replace("import android.app.Application;",
                              "import android.app.Application;\n"+imp, 1)
        if ini not in src:
            src = re.sub(r'(super\.onCreate\(\);)', r'\1\n'+ini, src, count=1)
        write(al, src); log_ok("AgouConfig.init() injected")

    # ── 8. Done ───────────────────────────────────────────────────────────────
    log_step("8/8","Done!")
    print(f"""
{G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{N}
{G}  ✅ AGOU Patch Complete!{N}
{G}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━{N}
  API ID   : {C}{api_id}{N}
  API Hash : {C}{api_hash[:8]}...{N}
  Package  : {C}agou.eko.telegram{N}
""")

if __name__ == "__main__": main()

# AGOU — Telegram Client
> **Package:** `agou.eko.telegram`  
> **Developer:** @A_KOJO / AKRO  
> **Based on:** [Telegram Open Source](https://github.com/DrKLO/Telegram) (GNU GPL v2.0)

---

## ما هو AGOU؟

AGOU هو تطبيق Telegram مخصص مبني على السورس الرسمي المفتوح لـ Telegram.  
نفس الحساب، نفس جهات الاتصال، نفس المجموعات - بس بواجهة AGOU الخاصة.

✅ سجّل بنفس رقمك العادي  
✅ شوف القصص  
✅ كلّم صحابك  
✅ كل features تليجرام موجودة  
✅ Theme أزرق داكن احترافي  

---

## خطوات البيلد (مهم اتبعها بالترتيب)

### الخطوة 1: احصل على API Credentials

1. روح على **https://my.telegram.org/apps**
2. سجّل بحسابك
3. اضغط "Create new application"
4. اكتب:
   - App title: `AGOU`
   - Short name: `agou`
   - Platform: `Android`
5. هياخدك لصفحة فيها:
   - `App api_id` (رقم زي `12345678`)
   - `App api_hash` (string زي `abc123def456...`)

⚠️ **دي بياناتك الشخصية - متشاركهاش مع حد**

### الخطوة 2: Clone Telegram Source

```bash
# Clone الأصلي
git clone https://github.com/DrKLO/Telegram.git TelegramSource

# أو
git clone git@github.com:DrKLO/Telegram.git TelegramSource
```

### الخطوة 3: دمج AGOU مع Telegram Source

```bash
# انسخ ملفات Telegram الأساسية
cp -r TelegramSource/TMessagesProj/src/main/java/org ./TMessagesProj/src/main/java/
cp -r TelegramSource/TMessagesProj/src/main/jni ./TMessagesProj/
cp -r TelegramSource/TMessagesProj/libs ./TMessagesProj/
cp -r TelegramSource/TMessagesProj/src/main/res/raw ./TMessagesProj/src/main/res/

# انسخ google-services
cp TelegramSource/TMessagesProj/google-services.json ./TMessagesProj/
```

### الخطوة 4: ضع API Keys

افتح `TMessagesProj/build.gradle` وعدّل:

```gradle
buildConfigField "int",    "APP_ID",    "12345678"        // ← رقمك
buildConfigField "String", "APP_HASH",  '"abcdef123456"'  // ← hashك
```

### الخطوة 5: Firebase Setup

1. روح **https://console.firebase.google.com**
2. Create new project باسم "AGOU"
3. Add Android app → package: `agou.eko.telegram`
4. Download `google-services.json`
5. ضعه في `/TMessagesProj/google-services.json`

### الخطوة 6: Build

```bash
# في Android Studio
# File → Open → اختار فولدر AGOU
# Build → Make Project

# أو من command line
./gradlew assembleDebug
```

---

## هيكل المشروع

```
AGOU/
├── TMessagesProj/
│   ├── src/main/
│   │   ├── java/agou/eko/telegram/
│   │   │   ├── AgouApp.java          ← Application class
│   │   │   ├── AgouConfig.java       ← إعدادات وألوان AGOU
│   │   │   ├── AgouFirebaseMessaging.java
│   │   │   ├── AgouBootReceiver.java
│   │   │   └── ui/
│   │   │       ├── LaunchActivity.java   ← Entry point
│   │   │       └── ExternalActionActivity.java
│   │   ├── res/
│   │   │   ├── values/
│   │   │   │   ├── strings.xml   ← اسم التطبيق AGOU
│   │   │   │   ├── colors.xml    ← ألوان AGOU
│   │   │   │   └── styles.xml    ← Theme AGOU
│   │   │   ├── drawable/
│   │   │   │   ├── ic_launcher_foreground.xml  ← أيقونة AGOU
│   │   │   │   └── ic_launcher_background.xml
│   │   │   └── xml/
│   │   │       ├── network_security_config.xml
│   │   │       └── file_paths.xml
│   │   └── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
└── settings.gradle
```

---

## التخصيصات

| الخاصية | القيمة |
|---------|--------|
| اسم التطبيق | AGOU |
| Package | agou.eko.telegram |
| Theme | Dark Blue + Electric Cyan |
| المطور | @A_KOJO / AKRO |
| Primary Color | `#00D4FF` |
| Background | `#0A0E1A` |

---

## الـ Features الإضافية (في AgouConfig.java)

- **Ghost Mode** — قراءة بدون علامة قراءة
- **Hide Phone** — إخفاء رقم الهاتف
- **Custom Theme** — ألوان AGOU الخاصة

---

## License

هذا المشروع مبني على [Telegram for Android](https://github.com/DrKLO/Telegram)  
المرخص تحت **GNU GPL v2.0**

وفق شروط الترخيص، أي تعديل يجب أن يكون open source أيضاً.

---

**AGOU** — *Built with ❤️ by @A_KOJO / AKRO*

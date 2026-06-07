# AGOU ProGuard Rules
# Based on Telegram's rules

-keep class org.telegram.** { *; }
-keep class agou.eko.telegram.** { *; }

-keep class com.google.android.gms.** { *; }
-keep class com.google.firebase.** { *; }

-dontwarn org.telegram.**
-dontwarn agou.eko.telegram.**

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep Parcelables
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable

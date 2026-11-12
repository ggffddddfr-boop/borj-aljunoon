# برج الجنون ← تطبيق أندرويد (Capacitor + AdMob)

## الخطوات
1. ثبّت Node.js 20+ و Android Studio.
2. داخل مجلد `app` شغّل: `./setup.sh`
3. `npx cap open android` ← من Android Studio شغّل على جوالك (Run).
4. لنسخة النشر: Build > Generate Signed Bundle (AAB).

## الإعلانات
- داخل `www/index.html` ابحث عن `ADMOB`: بدّل المعرّفات التجريبية بمعرّفاتك وخلّي `testing:false` قبل النشر.
- معرّف التطبيق (App ID) تبدّله بـ `AndroidManifest.xml` (السطر `com.google.android.gms.ads.APPLICATION_ID`).
- إعلانات المكافأة (كمّل، ضاعف، صناديق، عملات) فيديو شاشة كاملة من النظام، هذا شرط AdMob.
- إعلان بين الجولات صار مستطيل 300×250 بمربع بالوسط.
- بالمتصفح العادي يظهر الإعلان التجريبي كالسابق.

## تعديل اللعبة لاحقاً
عدّل `www/index.html` ثم: `npx cap sync android`

## ملاحظات
- أضف `localhost` لـ Authorized domains بـ Firebase Authentication إن لم يكن موجوداً.
- لا تنشر بمعرّفات تجريبية.

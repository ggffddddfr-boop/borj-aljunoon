#!/bin/bash
# شغّله مرة وحدة داخل مجلد app (يحتاج Node.js 20+ و Android Studio)
set -e
npm i @capacitor/core @capacitor/android @capacitor-community/admob
npm i -D @capacitor/cli
npx cap add android
# معرّف تطبيق AdMob (هذا تجريبي، بدّله بمعرّفك الحقيقي) داخل <application>
MF=android/app/src/main/AndroidManifest.xml
if ! grep -q "com.google.android.gms.ads.APPLICATION_ID" "$MF"; then
  sed -i 's#</application>#    <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-3940256099942544~3347511713"/>\n    </application>#' "$MF"
fi
npx cap sync android
echo "تم. افتح المشروع: npx cap open android"

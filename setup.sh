#!/bin/bash
# برج الجنون: بناء مشروع أندرويد (Capacitor + AdMob)
set -e
npm i @capacitor/core @capacitor/android @capacitor-community/admob
npm i -D @capacitor/cli
npx cap add android

# اسم التطبيق اللي يطلع تحت الأيقونة وبقائمة التطبيقات
SR=android/app/src/main/res/values/strings.xml
if [ -f "$SR" ]; then
  sed -i 's#<string name="app_name">[^<]*</string>#<string name="app_name">برج الجنون</string>#; s#<string name="title_activity_main">[^<]*</string>#<string name="title_activity_main">برج الجنون</string>#' "$SR"
fi

# معرّف تطبيق AdMob (تجريبي، بدّله بمعرّفك الحقيقي)
MF=android/app/src/main/AndroidManifest.xml
if ! grep -q "com.google.android.gms.ads.APPLICATION_ID" "$MF"; then
  sed -i 's#</application>#    <meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="ca-app-pub-3940256099942544~3347511713"/>\n    </application>#' "$MF"
fi

# إصلاح: اللعبة ما تتداخل مع شريط الحالة وأزرار النظام
JD=android/app/src/main/java/com/aljunoon/tower
mkdir -p "$JD"
cat > "$JD/MainActivity.java" <<'JAVA'
package com.aljunoon.tower;

import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    View root = findViewById(android.R.id.content);
    root.setBackgroundColor(Color.parseColor("#1A1244"));
    ViewCompat.setOnApplyWindowInsetsListener(root, (v, insets) -> {
      Insets bars = insets.getInsets(WindowInsetsCompat.Type.systemBars() | WindowInsetsCompat.Type.displayCutout());
      v.setPadding(bars.left, bars.top, bars.right, bars.bottom);
      return WindowInsetsCompat.CONSUMED;
    });
  }
}
JAVA

# أيقونة التطبيق: الصور icon-*.png بجنب هذا الملف
mkdir -p assets && cp icon-only.png icon-foreground.png icon-background.png assets/
npm i -D @capacitor/assets
npx capacitor-assets generate --android

npx cap sync android
echo "تم. افتح المشروع: npx cap open android"

# Expense Tracker Lite (Flutter)


## Flutter Version)  
```bash
3.29.3
```

## 1) Flutter Run
```bash
flutter pub get
flutter run
```

 (Generate Adapters):
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 2)  Main Features 
- لوحة تحكم: إجمالي الرصيد/الدخل/المصروفات + Filters + آخر المصروفات
- إضافة مصروف: الفئة، المبلغ، التاريخ، العملة، إيصال اختياري
- تحويل عملات تلقائي إلى USD باستخدام API
-  (Hive)
-  (Pagination) 10 

## 3)  (Clean Architecture)
```
lib/
├─ core/            # api_client, hive_helper, constants
├─ features/
│  ├─ expense/      # data/domain/presentation (BLoC)
│  ├─ currency/     # data/domain/presentation (BLoC)
│  ├─ dashboard/    # UI الرئيسية
│  └─ add_expense/  # UI إضافة مصروف
└─ main.dart
```

- UI ⇄ BLoC ⇄ Repository ⇄ Data Sources (Local/Remote)
-  Main States : Loading, Loaded, Error

## 4) Packages
```yaml
flutter_bloc, equatable, hive, hive_flutter, dio, intl, uuid
dev: build_runner, hive_generator, bloc_test, mockito
```

## 5) Currency
- API: https://open.er-api.com/v6/latest/USD
- عند الحفظ: يتم تحويل المبلغ إلى USD وتخزين `amount` الأصلي + `convertedAmount`
- الحسابات في لوحة التحكم تعتمد على USD فقط لثبات الأرقام


## 6) Fastlane 
```bash
bundle install
bundle exec fastlane android:play_release   # أندرويد (Google Play)
bundle exec fastlane android:upload_huawei  # هواوي AppGallery
bundle exec fastlane ios:testflight_release # iOS TestFlight
```

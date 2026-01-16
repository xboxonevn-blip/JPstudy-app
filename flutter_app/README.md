# JP Study Flutter Shell

This folder contains a Flutter UI skeleton that mirrors the A/B/C/D workflow.

## Bootstrap
1) Install Flutter and add it to PATH.
2) From this folder, generate platform runners:

```
flutter create . --project-name jpstudy_flutter --org com.jpstudy --platforms=android,ios,web,windows,macos,linux
```

If `flutter create` overwrites `lib/main.dart`, restore it from git.

## Run
```
flutter pub get
flutter run -d chrome
```

## Drift (SQLite) codegen
The database schema lives in `lib/data/database.dart`.
Generate the Drift companion code with:
```
flutter pub run build_runner build --delete-conflicting-outputs
```

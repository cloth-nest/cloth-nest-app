# Clothnest App
## Members
- Mai Phạm Quốc Hưng - MSSV: 20521366
- Nguyễn Thái Tuấn - MSSV: 20522122​
- Phạm Trương Hải Đoàn - MSSV: 20520046

## Source Structure

```
├── lib
│   ├── app                     # Contains common components
│   │   ├── config              # Contains configuration files
│   │   ├── constant            # Contains constant values
│   │   ├── enum                # Contains enumerations
│   │   ├── global              # Contains global variables
│   │   ├── navigator           # Contains navigation-related files
│   │   ├── res                 # Contains resource files
│   │   ├── service             # Contains service files
│   ├── generated               # Contains generated localization keys
│   ├── data                    # Contains data files
|   │   ├── models              # Contains models
|   │   ├── cache               # Contains class definition for local storage
|   │   ├── helper              # Contains helper methos for handle response
|   │   ├── http                # Contains class definition for remote storage
|   │   ├── usecases            # Contains usecases
│   ├── domain                  # Contains domain-related files
│   │   ├── entities            # Contains entities
│   │   ├── usecases            # Contains usecases
│   ├── presentation            # Contains presentation files
|   │   ├── presenters          # Contains logic UI
|   │   ├── screens             # Contains UI
|   │   ├── widgets             # Contains common widgets
│   ├── util                    # Contains utility files
│   └── main.dart               # Main file that runs the application
├── assets                      # Contains assets such as images, translations, etc.
```

## How to run
B1. Clone repo:
```bash
git clone https://github.com/cloth-nest/cloth-nest-app.git
```
B2. Open terminal to this repo and run:
```bash
flutter pub get
flutter pub run easy_localization:generate -S "assets/translations" -O "lib/app/res" -f keys -o locale_keys.g.dart
flutter pub run build_runner build --delete-conflicting-outputs
```
B3. To run app, run this in your terminal
```bash
flutter run
```

## Generate hive

```
flutter pub run build_runner build --delete-conflicting-outputs
```

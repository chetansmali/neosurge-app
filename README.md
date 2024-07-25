![image](assets/app_icons/splash_logo.png)

Mobile Application for BullSurge Team that has been developed for users to invest in Mutual Funds and Digital Gold.

## Getting Started

This project is built with [Flutter](https://flutter.dev/).

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- [Android SDK](https://developer.android.com/studio/releases/platform-tools)
- [Android Emulator](https://developer.android.com/studio/run/emulator)
  or [iOS Simulator](https://developer.apple.com/xcode/simulator/)
- [Git](https://git-scm.com/downloads)
- [Dart](https://dart.dev/get-dart)

### Installing

- Clone the repository

```bash
git clone https://github.com/Mindstack-Technologies/bullsurge-mobile.git
```

- Install dependencies

```bash
flutter pub get
```

- Run the build runner to generate the files

```bash
 flutter pub run build_runner run --delete-conflicting-outputs
```

#### Running the app

- The command would be as follows

    - To run the app:
    ```bash
    flutter run -t <path to main.dart file> --flavor <flavor name>
    ```
    - For building apk:
    ```bash
    flutter build apk -t <path to main.dart file> --flavor <flavor name>
    ```
    - For building apk:
  ```bash
    flutter build appbundle -t <path to main.dart file> --flavor <flavor name>
  ```

The project is configured to run on both Android and iOS devices. The project has 3 environments:

- Development (flavor name: dev && path to main.dart file: lib/main_dev.dart)
- Staging (flavor name: staging && path to main.dart file: lib/main_staging.dart)
- Production (flavor name: prod && path to main.dart file: lib/main_prod.dart)


## Architecture of the app 

![clean_arch](https://github.com/Mindstack-Technologies/bullsurge-mobile/assets/142197973/c7d77e0e-ba2a-4031-9a52-70b42b795d49)


       




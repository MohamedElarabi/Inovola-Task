fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### doctor

```sh
[bundle exec] fastlane doctor
```



----


## Android

### android build_play

```sh
[bundle exec] fastlane android build_play
```

Clean, pub get, build android appbundle (release)

### android upload_play

```sh
[bundle exec] fastlane android upload_play
```

Upload AAB to Google Play (internal track)

### android play_release

```sh
[bundle exec] fastlane android play_release
```

Build and upload to Google Play internal

### android upload_huawei

```sh
[bundle exec] fastlane android upload_huawei
```

Upload AAB to Huawei AppGallery

----


## iOS

### ios build_ios

```sh
[bundle exec] fastlane ios build_ios
```

Clean, pub get, build iOS IPA (release)

### ios upload_testflight

```sh
[bundle exec] fastlane ios upload_testflight
```

Upload IPA to TestFlight

### ios testflight_release

```sh
[bundle exec] fastlane ios testflight_release
```

Build and upload to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

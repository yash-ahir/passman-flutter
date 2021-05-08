# PassMan 
<img src="https://github.com/yash-ahir/passman-flutter/blob/main/promotional_assets/feature_graphic.png">
PassMan Logo © 2021 by Yash Ahir is licensed under CC BY-NC 4.0 

### A simple, cross-platform password manager created with Flutter.

<a href='https://play.google.com/store/apps/details?id=com.yashahir.passman&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1'><img alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png' width='180'/></a>
---
### How to run this
- Install Flutter for your platform of choice from [here](https://flutter.dev/docs/get-started/install).
- This project uses [Moor](https://pub.dev/packages/moor) for persistent storage and as such supports [all platforms that Moor does](https://moor.simonbinder.eu/docs/platforms/). As mentioned in the supported platforms page for it, for desktop support most Linux distrubutions include a SQLite binary and MacOS will utilize the `VmDatabase` class (A Moor database that runs in a Dart VM), so no extra steps for it. For Windows or a Linux distribution without SQLite, you need to [download](https://sqlite.org/download.html) and install SQLite. Note: I might ship a pre-compiled SQLite binary for individual platform packages when I release version 1.0 executables for all platforms.
- For desktop support, also make sure to follow the requirements [here](https://flutter.dev/desktop).
- Clone the repository. After it is cloned `cd` into the repository directory and run `flutter run --release`. This will launch the application in release mode, if you want to utilize hot-reloading and hot-restarting for any reason, omit the `--release` flag.

---
## License
GPLv3

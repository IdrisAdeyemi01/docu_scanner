# Docu Scanner

Document scanner with edge detection functionality

## Introduction

This project is my submission for the Receiptflow Senior Flutter Developer task

### Features

- On-device machine learning for documents scanning
- Edge detection capability
- Use of Google ML Kit for document scanning through Native Kotlin implementation
- No third-party Flutter library implementation
- Ability to share the scanned document as PDF
- Ability to crop and edit images

### Implementation / Architectural Decision

Although the project is a simple app in terms of its frontend capacity, the project was still implemented as though it was going to grow into an enterprise app using the MVVM approach.
- State Management was done with setState (with a growth route towards use of Riverpod for SM and DI)
- File/Folder structure ensures large codebase ease of maintenance

### Build Limitations

- The project depends on Google ML KIt Document scanner which, at the time of writing, does not have support for iOS
- No third-party library or package were used
- The web and desktop environments were not prioritized for this submission.
- CI / CD was not prioritized for this submission.
- Flavors were not prioritized for this submission.
- Analytics and Error Reporting was not prioritized for this submission.

### Setup Instructions

- run `git clone https://github.com/IdrisAdeyemi01/docu_scanner.git` in your terminal
- navigate to the directory containing the cloned project (docu_scanner)
- open in any code editor of your choice e.g Android studio, VSCode etc
- connect your Android device
- run `flutter run` to test in your connected device

* You can also simply install the app's apk to text. [Docu Scanner](https://drive.google.com/file/d/1DwYd2ziZA78f--cfG2aw8vmJO9Vmwud5/view?usp=sharing)

Built with ❤️ in Flutter. Powered by Google ML Kit.
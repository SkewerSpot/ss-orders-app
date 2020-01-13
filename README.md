<p align="center">
    <img width=200 height=200 src="https://user-images.githubusercontent.com/1288616/72237619-1c8b9b80-3601-11ea-8a60-2190accad43c.png" alt="SS Orders logo">
<p>

# SS Orders

> A companion app of [SS Menu](https://github.com/SkewerSpot/ss-menu-app).

A no-nonsense app for managing restaurant orders in the kitchen.

#### Table of contents

- [History](#history)
- [Current Design](#current-design)
- [Features](#features)
- [Caveats](#caveats)
- [Why You Should Use It?](#why-you-should-use-it)
- [Getting Started](#getting-started)
- [Building](#building)
- [Distributing](#distributing)
- [Screenshots](#screenshots)
- [Credits](#credits)
- [Contact](#contact)

## Motivation

<img width=200 height=200 src="https://user-images.githubusercontent.com/1288616/72238661-65911f00-3604-11ea-914f-fde746ead9b1.jpeg" alt="Thank you image">

As noted in the [history](#history) section below, this app was earlier created in Ionic. The main motivation for a complete rewrite was integration with our [loyalty program](https://github.com/SkewerSpot/thankyou-gen), in which we send out collectible printed "thank you" notes to our customers. Each note has a 6-digit unique code, a certain number of which a customer may redeem for a free meal. The new SS Orders app allows restaurant owners to attach a thank you note's unique code with an order in database before sending the note to customer.

## History

> See https://github.com/SkewerSpot/ss-menu-app#history

## Current Design

> See https://github.com/SkewerSpot/ss-menu-app#current-design

## Features

- Displays a list of currently open (pending) orders
- Displays a list of recently closed (completed/cancelled) orders
- Mark an order as completed
- Mark an order as cancelled
- Mark an order as paid
- Mark an order as receipt issued
- Apply discount on an order
- **Attach an order with a unique code (part of [loyalty program](https://github.com/SkewerSpot/thankyou-gen))**
- The convenience of managing orders from a mobile device
- Works well on old devices (tested on HTC One series and Xiaomi Redmi phones)
- Well-documented code

## Caveats

- iOS version is missing
- No special arrangements for accessibility
- Missing i18n (internationlization) and l10n (localization)
- More automated tests
- No CI/CD

## Why You Should Use It?

> See https://github.com/SkewerSpot/ss-menu-app#why-you-should-use-it

## Getting Started

1. Install Flutter (read the official docs). Ensure Android SDK support: let `flutter doctor` help you with that.
2. Install Flutter/Dart support in your IDE. I use Visual Studio Code.
3. Clone this repo locally.
4. Open the repo directory in your IDE. It should ideally automatically fetch missing dependencies (packages) for you. If not, run the command `flutter pub get`.
5. Create a new Firebase realtime database (or reuse the one you created for [SS Menu](https://github.com/SkewerSpot/ss-menu-app)). Follow the [steps for adding an Android app](https://firebase.google.com/docs/android/setup). Download `google-services.json` file and add it under **android/app** folder. (skip the parts about adding Firebase SDK)
6. Run the app (press F5) in Android Simulator (API 28; Google APIs Intel x64 image).
7. Tada! It's up and running.
8. Drop me a line if you face an issue. (contact details below)

## Building

```
flutter build apk
```

This produces a 'fat' APK (Android app archive with support for lots of CPU architectures). To keep the file size small, create targeted APKs using:

```
flutter build apk --split-per-abi
```

## Distributing

Once the APK is built, install it on your/client's/friend's Android phone either via `adb install` or by sharing a download link to your APK.

## Screenshots

<p>
    <img height=400 src="https://user-images.githubusercontent.com/1288616/72238840-08499d80-3605-11ea-9116-da32c0a6fe78.png" alt="Screenshot of open orders tab, which is currently empty" />
    <img height=400 src="https://user-images.githubusercontent.com/1288616/72238839-07b10700-3605-11ea-855b-b80e6ca14844.png" alt="Screenshot of a list of closed orders" />

</p>

## Credits

- Logo icon made by [Freepik](https://www.freepik.com/home) from www.flaticon.com
- Thank You image made by [Freepik](https://www.freepik.com/home) from www.flaticon.com

## Contact

Anurag Bhandari, 2020  
✉️[skewerspot.cafe@gmail.com](mailto:skewerspot.cafe@gmail.com)
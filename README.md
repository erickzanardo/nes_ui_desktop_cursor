# Nes Ui Desktop Cursor

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![License: MIT][license_badge]][license_link]

A flutter package that allows Nes UI Icon's to be used a mouse cursor on desktop

## Installation 💻

**❗ In order to start using Nes Ui Desktop Cursor you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Install via `flutter pub add`:

```sh
dart pub add nes_ui_desktop_cursor
```

## How to use it

Before you can use a `NesIconData` as a cursor, they need to be registered in the
`NesUIDesktopCursor` instance.

To do so:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const pixelSize = 4.0;
  const palette = [
    Colors.black,
    Colors.white,
  ];

  await NesUIDesktopCursor.instance.addCursor(
    NesIcons.arrowCursor,
    pixelSize: pixelSize,
    palette: palette,
  );
}
```

Or multiple cursors can be registered with `addMultipleCursors`:

```dart
await NesUIDesktopCursor.instance.addMultipleCursors(
  icons: [
    NesIcons.arrowCursor,
    NesIcons.leftHand,
    NesIcons.axe,
    NesIcons.check,
  ],
  pixelSize: pixelSize,
  palette: palette,
);
```

Then to use the registered cursors, the Flutter `MouseRegion` widget can be used:

```dart
MouseRegion(
  cursor: NesUIDesktopCursor.instance.getNesCursor(
    NesIcons.leftHand,
  ),
  child: ...
),
```

[flutter_install_link]: https://docs.flutter.dev/get-started/install
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://pub.dev/packages/very_good_cli
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows

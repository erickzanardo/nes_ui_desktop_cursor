// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:nes_ui_desktop_cursor/nes_ui_desktop_cursor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const pixelSize = 4.0;
  const palette = [
    Colors.black,
    Colors.white,
  ];

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: flutterNesTheme(
        nesTheme: NesTheme(
          pixelSize: 2,
          clickCursor: NesUIDesktopCursor.instance.getNesCursor(
            NesIcons.leftHand,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _cursor = NesIcons.arrowCursor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        cursor: NesUIDesktopCursor.instance.getNesCursor(
          _cursor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: NesContainer(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Column(
                children: [
                  const Text('Change your mouse cursor'),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NesIconButton(
                        icon: NesIcons.arrowCursor,
                        onPress: () =>
                            setState(() => _cursor = NesIcons.arrowCursor),
                      ),
                      const SizedBox(width: 16),
                      NesIconButton(
                        icon: NesIcons.check,
                        onPress: () =>
                            setState(() => _cursor = NesIcons.check),
                      ),
                      const SizedBox(width: 16),
                      NesIconButton(
                        icon: NesIcons.axe,
                        onPress: () => setState(() => _cursor = NesIcons.axe),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

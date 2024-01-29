import 'dart:io';
import 'dart:ui';

import 'package:flame_mini_sprite/flame_mini_sprite.dart';
import 'package:flutter_custom_cursor/cursor_manager.dart';
import 'package:flutter_custom_cursor/flutter_custom_cursor.dart';
import 'package:image/image.dart' as image;
import 'package:nes_ui/nes_ui.dart';
import 'package:uuid/uuid.dart';

/// {@template nes_ui_desktop_cursor_failure}
/// Thrown when an error occurs while using [NesUIDesktopCursor].
/// {@endtemplate}
class NesUIDesktopCursorFailure implements Exception {
  /// {@macro nes_ui_desktop_cursor_failure}
  NesUIDesktopCursorFailure(this.message);

  /// The error message.
  final String message;
}

/// {@template nes_ui_desktop_cursor}
/// A flutter package that allows Nes UI Icon's to be used a mouse cursor on
/// desktop.
/// {@endtemplate}
class NesUIDesktopCursor {
  /// {@macro nes_ui_desktop_cursor}
  NesUIDesktopCursor._();

  /// The singleton instance of [NesUIDesktopCursor].
  static final instance = NesUIDesktopCursor._();

  final Map<NesIconData, String> _cursorCache = {};

  /// Adds multiple [NesIconData] as cursors to be used in the application.
  Future<void> addMultipleCursors({
    required List<NesIconData> icons,
    required double pixelSize,
    required List<Color> palette,
  }) async {
    await Future.wait(
      [
        for (final icon in icons)
          addCursor(
            icon,
            pixelSize: pixelSize,
            palette: palette,
          ),
      ],
    );
  }

  /// Adds a [NesIconData] as a cursor to be used in the application.
  Future<void> addCursor(
    NesIconData icon, {
    required double pixelSize,
    required List<Color> palette,
  }) async {
    final sprite = await icon.sprite.toSprite(
      pixelSize: pixelSize,
      palette: palette,
    );

    final originalImage = sprite.image;
    final originalByteData = await originalImage.toByteData(
      format: ImageByteFormat.png,
    );
    if (originalByteData == null) {
      throw NesUIDesktopCursorFailure(
        'Failed to get byte data from sprite image.',
      );
    }

    var bytes = originalByteData.buffer.asUint8List();
    if (Platform.isWindows) {
      final img = image.decodeImage(bytes);

      if (img == null) {
        throw NesUIDesktopCursorFailure(
          'Failed to decode image from sprite image.',
        );
      }

      bytes = img.getBytes(order: image.ChannelOrder.bgra).buffer.asUint8List();
    }

    const uuid = Uuid();

    final cursorName = await CursorManager.instance.registerCursor(
      CursorData()
        ..name = uuid.v4()
        ..buffer = bytes
        ..height = originalImage.height
        ..width = originalImage.width
        ..hotX = 0
        ..hotY = 0,
    );

    _cursorCache[icon] = cursorName;
  }

  /// Gets a [FlutterCustomMemoryImageCursor] from a [NesIconData].
  ///
  /// Make sure to call [addCursor] with the icon data before using this method.
  FlutterCustomMemoryImageCursor getNesCursor(NesIconData icon) {
    return FlutterCustomMemoryImageCursor(key: _cursorCache[icon]);
  }
}

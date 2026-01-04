import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MediaDownloaderWithGallery {
  Future<String?> getDownloadedFilePath(String url) async {
    try {
      final Directory dir = Platform.isAndroid
          ? (await getExternalStorageDirectory()) ?? await getTemporaryDirectory()
          : await getApplicationDocumentsDirectory();

      final fileExtension = _getFileExtension(url);
      final nameWithoutExtension = _getFileNameWithoutExtension(url);

      return '${dir.path}/$nameWithoutExtension.$fileExtension';
    } catch (e) {
      debugPrint('Error determining file path: $e');
      return null;
    }
  }

  String _getFileExtension(String url) {
    try {
      return url.split('.').last.split('?').first.toLowerCase();
    } catch (_) {
      return 'jpg'; // default extension
    }
  }

  String _getFileNameWithoutExtension(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.pathSegments.last.split('.').first;
    } catch (_) {
      return 'file_${DateTime.now().millisecondsSinceEpoch}';
    }
  }

  bool isImageFile(String url) {
    final ext = _getFileExtension(url);
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(ext);
  }
}

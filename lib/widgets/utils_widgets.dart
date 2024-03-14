import 'dart:io';

import 'package:calendar/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';

class Utils {
  final picker = ImagePicker();

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
    } else {}
  }

  Future<String?> saveImageToFileSystem(File imageFile) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String imagePath = '${directory.path}/image.jpg';
      final File newImage = await imageFile.copy(imagePath);
      return imagePath;
    } catch (e) {
      print('Failed to save image to file system: $e');
      return null;
    }
  }

  void customSnackBar(
    BuildContext context,
    String content,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: ThemeClass().grey, content: Text(content)),
    );
  }
}

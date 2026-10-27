import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class FileUtils {
  FileUtils._();

  static Future<Directory> get documentsDir =>
      getApplicationDocumentsDirectory();
  static Future<Directory> get tempDir => getTemporaryDirectory();

  static Future<File?> pickImageFromGallery({double? maxWidth, double? maxHeight}) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    return xFile != null ? File(xFile.path) : null;
  }

  static Future<File?> pickImageFromCamera({double? maxWidth, double? maxHeight}) async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );
    return xFile != null ? File(xFile.path) : null;
  }

  static Future<List<File>> pickMultipleImages() async {
    final picker = ImagePicker();
    final xFiles = await picker.pickMultiImage();
    return xFiles.map((f) => File(f.path)).toList();
  }

  static String getExtension(String path) =>
      path.split('.').last.toLowerCase();

  static String getFileName(String path) =>
      path.split(Platform.pathSeparator).last;

  static bool isImage(String path) =>
      ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp']
          .contains(getExtension(path));

  static Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) await file.delete();
  }

  static Future<int> getFileSize(String path) async {
    final file = File(path);
    return await file.length();
  }
}

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/logger_utils.dart';

class FirebaseStorageService {
  FirebaseStorageService._();
  static final FirebaseStorageService instance = FirebaseStorageService._();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadFile({
    required File file,
    required String path,
    Function(double)? onProgress,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      final task = ref.putFile(file);

      task.snapshotEvents.listen((snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      await task;
      final url = await ref.getDownloadURL();
      AppLogger.info('✅ File uploaded: $url');
      return url;
    } catch (e) {
      AppLogger.error('❌ Upload failed: $e');
      return null;
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      await _storage.ref().child(path).delete();
    } catch (e) {
      AppLogger.error('❌ Delete failed: $e');
    }
  }

  Future<String?> getDownloadUrl(String path) async {
    try {
      return await _storage.ref().child(path).getDownloadURL();
    } catch (e) {
      AppLogger.error('❌ Get URL failed: $e');
      return null;
    }
  }
}

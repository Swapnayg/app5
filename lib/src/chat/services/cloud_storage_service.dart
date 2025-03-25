import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  FirebaseStorage _storage;
  StorageReference _baseRef;

  final String _profileImages = "profile_images";
  final String _messages = "messages";
  final String _images = "images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<StorageTaskSnapshot> uploadUserImage(String uid, File image) {
    try {
      return _baseRef
          .child(_profileImages)
          .child(uid)
          .putFile(image)
          .onComplete;
    } catch (e) {
      print(e);
    }
  }

  Future<StorageTaskSnapshot> uploadMediaMessage(String uid, File file) {
    var timestamp = DateTime.now();
    var fileName = basename(file.path);
    fileName += "_${timestamp.toString()}";
    try {
      return _baseRef
          .child(_messages)
          .child(uid)
          .child(_images)
          .child(fileName)
          .putFile(file)
          .onComplete;
    } catch (e) {
      print(e);
    }
  }
}

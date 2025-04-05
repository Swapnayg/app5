// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class CloudStorageService {
  static CloudStorageService instance = CloudStorageService();

  late FirebaseStorage _storage;
  late Reference _baseRef;

  final String _profileImages = "profile_images";
  final String _messages = "messages";
  final String _images = "images";

  CloudStorageService() {
    _storage = FirebaseStorage.instance;
    _baseRef = _storage.ref();
  }

  Future<TaskSnapshot> uploadUserImage(String _uid, File _image) {
    try {
      return _baseRef
          .child(_profileImages)
          .child(_uid)
          .putFile(_image)
          .whenComplete(() => print("Upload complete"));
    } catch (e) {
      print(e);
      throw Exception("Failed to upload user image: $e");
    }
  }

  Future<TaskSnapshot> uploadMediaMessage(String _uid, File _file) {
    var _timestamp = DateTime.now();
    var _fileName = basename(_file.path);
    _fileName += "_${_timestamp.toString()}";
    try {
      return _baseRef
          .child(_messages)
          .child(_uid)
          .child(_images)
          .child(_fileName)
          .putFile(_file)
          .whenComplete(() => print("Upload complete"));
    } catch (e) {
      print(e);
      throw Exception("Failed to upload media message: $e");
    }
  }
}

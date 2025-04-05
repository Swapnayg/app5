

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = MediaService();

  Future<XFile?> getImageFromLibrary() {
    final picker = ImagePicker();
    return picker.pickImage(source: ImageSource.gallery);
  }
}

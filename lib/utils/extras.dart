
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class Extras {
  static Future<PickedFile> pickImage(bool fromCamera) async {
    final ImagePicker picker = ImagePicker();
    final PickedFile file = await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    return file;
  }

  static getFilename(String filePath) {
    return basename(filePath);
  }

}
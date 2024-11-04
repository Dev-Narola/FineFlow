import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageServicesFromCamera extends GetxController {
  final firebaseStorage = FirebaseStorage.instance;

  var imageUrl = <String>[].obs;
  var isLoading = false.obs;
  var isUploading = false.obs;

  Future<void> fetchImages() async {
    isLoading.value = true;
    final ListResult result =
        await firebaseStorage.ref('upload_images/').listAll();

    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    imageUrl.assignAll(urls);
    isLoading.value = false;
  }

  Future<String?> uploadImage() async {
    isUploading.value = true;

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    // print("---------------------------------------" + image!.toString());
    if (image == null) {
      isUploading.value = false;
      print(
          "-------------------------------- image value is null --------------");
      return null;
    }

    File file = File(image.path);
    try {
      String filePath = 'upload_images/${DateTime.now()}.png';

      await firebaseStorage.ref(filePath).putFile(file);

      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      imageUrl.add(downloadUrl);
      print("==========================================" + downloadUrl);
      return downloadUrl;
    } catch (e) {
      print("Error Uploading: " + e.toString());
      Get.snackbar("Upload Error", "Failed to upload image: $e");
      return null;
    } finally {
      isUploading.value = false;
    }
  }
}

import 'package:api/models/api_response.dart';
import 'package:api/models/student_images.dart';
import 'package:get/get.dart';
import '../api/image_api_controller.dart';

class ImageGetController extends GetxController {
  final ImagesApiController _apiController = ImagesApiController();
 static ImageGetController get to => Get.find();
  List<StudentImage> images = <StudentImage>[];
    RxBool loading = false.obs ;
  @override
  void onInit() {
    read() ;
    super.onInit();
  }

  void read() async {
    images = await _apiController.getImages();
    update();

  }

  Future<ApiResponse> uploadImage({required String path}) async {
    ApiResponse<StudentImage> apiResponse =
        await _apiController.uploadImage(path: path);
    if (apiResponse.success && apiResponse.object != null) {
      images.add(apiResponse.object!);
      update();
    }
    return apiResponse;
  }

  Future<ApiResponse> deletedImage(int index) async {
    ApiResponse apiResponse =
        await _apiController.deleteImage(id: images[index].id);
    if (apiResponse.success) {
      images.removeAt(index);
      update();

    }
    return apiResponse;
  }
}

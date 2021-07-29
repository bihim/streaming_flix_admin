import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as DIO;
import 'package:dio/dio.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:streaming_flix_admin/api/api_client.dart';

class AddVideoController extends GetxController {
  var videoUpload = ['link', 'upload'];
  var videoUploadIndex = 0.obs;
  var fileName = 'No File Chosen'.obs;
  late PlatformFile platformFile;
  Uint8List? uint8list;


  Future pickFiles() async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(type: FileType.video, withData: true);
    //File file = File(result!.files.single.path!);

    if (result!=null) {
      platformFile = result.files.single;
      fileName.value = result.files.first.name;
    }
    return platformFile;
  }

  uploadVideoApi (String name, String year, String description, String category, String imageLink, String isFeatured, String isUploaded, PlatformFile platformFile) async{
    final client = ApiClient(Dio(BaseOptions(contentType: 'multipart/form-data')));
    DIO.MultipartFile file = await DIO.MultipartFile.fromFile(platformFile.path!, filename: platformFile.name);
    client.uploadVideo(name, year, description, category, imageLink, isFeatured, isUploaded, file);
  }
}

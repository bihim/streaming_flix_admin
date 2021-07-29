import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:streaming_flix_admin/controller/add_video_screen_controller.dart';
import 'package:streaming_flix_admin/global/global_values.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class AddVideoScreenWeb extends StatelessWidget {
  AddVideoController _addVideoController = Get.put<AddVideoController>(AddVideoController());
  TextEditingController _textEditingControllerMovieName = TextEditingController();
  TextEditingController _textEditingControllerYear = TextEditingController();
  TextEditingController _textEditingControllerDescription = TextEditingController();
  TextEditingController _textEditingControllerCategory = TextEditingController();
  TextEditingController _textEditingControllerImageLink = TextEditingController();
  TextEditingController _textEditingControllerMovieLink = TextEditingController();
  late PlatformFile platformFile;
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () {
          return Padding(
            padding: EdgeInsets.all(4.h),
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.h),
                ),
                elevation: 2.h,
                shadowColor: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.h),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(9.h),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Text(
                            'Add New Video',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingControllerMovieName,
                              decoration: InputDecoration(
                                labelText: 'Enter Movie Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _textEditingControllerYear,
                              decoration: InputDecoration(
                                labelText: 'Enter Year',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        height: 20.h,
                        child: TextField(
                          controller: _textEditingControllerDescription,
                          textAlignVertical: TextAlignVertical.top,
                          keyboardType: TextInputType.multiline,
                          expands: true,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Enter Movie Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingControllerCategory,
                              decoration: InputDecoration(
                                helperText: 'Case-sensitive',
                                labelText: 'Enter Category',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _textEditingControllerImageLink,
                              decoration: InputDecoration(
                                labelText: 'Enter Movie Image Link',
                                helperText: '',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text('Add Video Link'),
                              leading: Radio(
                                groupValue: _addVideoController.videoUpload[_addVideoController.videoUploadIndex.value],
                                value: _addVideoController.videoUpload[0],
                                onChanged: (_) {
                                  _addVideoController.videoUploadIndex.value = 0;
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                'Upload Video',
                                textAlign: TextAlign.end,
                              ),
                              trailing: Radio(
                                groupValue: _addVideoController.videoUpload[_addVideoController.videoUploadIndex.value],
                                value: _addVideoController.videoUpload[1],
                                onChanged: (_) {
                                  _addVideoController.videoUploadIndex.value = 1;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: AnimatedOpacity(
                              opacity: _addVideoController.videoUploadIndex.value == 0 ? 1.0 : 0.25,
                              duration: Duration(milliseconds: 600),
                              child: TextField(
                                controller: _textEditingControllerMovieLink,
                                enabled: _addVideoController.videoUploadIndex.value == 0 ? true : false,
                                decoration: InputDecoration(
                                  labelText: 'Enter Movie Video Link',
                                  helperText: 'Note: Enter video link containing .mp4/.avi/.mkv\nOtherwise movie will not be able to play',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.h,
                          ),
                          Expanded(
                            child: AnimatedOpacity(
                              opacity: _addVideoController.videoUploadIndex.value == 1 ? 1.0 : 0.25,
                              duration: Duration(milliseconds: 600),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(_addVideoController.fileName.value),
                                  SizedBox(
                                    width: 2.h,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_addVideoController.videoUploadIndex.value == 0) {
                                        return null;
                                      } else {
                                        platformFile = await _addVideoController.pickFiles();
                                        logger.d('Filename: ${platformFile.name}');
                                      }
                                    },
                                    child: Text(
                                      'Choose File',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          /*final client = ApiClient(Dio(BaseOptions(headers: {'Content-type': 'multipart/form-data',
                            'Accept': 'application/json'} )));
                          AddVideoModel addVideoModel = await client.uploadVideo(_textEditingControllerMovieName.text, _textEditingControllerYear.text, _textEditingControllerDescription.text, _textEditingControllerCategory.text, _textEditingControllerImageLink.text, 'true', 'true', DIO.MultipartFile.fromBytes(platformFile.bytes!, filename: platformFile.name)).catchError((onError){
                            logger.e(onError.toString());
                          });
                          logger.d('Success Result ${addVideoModel.status.toString()}');*/


                          var formData = DIO.FormData.fromMap({
                            'name': 'example',
                            'year': 'example',
                            'description': 'example',
                            'category': 'example',
                            'image_link': 'example',
                            'is_featured': 'true',
                            'is_uploaded': 'true',
                            'file': DIO.MultipartFile.fromBytes(platformFile.bytes!, filename: platformFile.name, contentType: MediaType('video', 'mp4'))
                          });

                          var dio = Dio();
                          dio.options.headers = {
                            'Content-Type': 'multipart/form-data'
                          };

                          var response = await dio.post(GlobalValues.baseUrl + "/video/add", data: formData);
                          logger.d(response);

                          /*String url = '${GlobalValues.baseUrl}/video/justAdd';
                          var headers = {
                            'Content-type': 'multipart/form-data', 'Accept': 'application/json',
                          };

                          var request = http.MultipartRequest('POST', Uri.parse(url));
                          request.headers.addAll(headers);
                          Uint8List? data = platformFile.bytes;
                          List<int> list = data!.cast();
                          request.files.add(http.MultipartFile.fromBytes('file', list, filename: 'Laravel.mp4'));
                          var response = await request.send();

                          response.stream.bytesToString().asStream().listen((event) {
                            var parsedJson = json.decode(event);
                            logger.d(parsedJson);
                            logger.d(response.statusCode);
                          });*/
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

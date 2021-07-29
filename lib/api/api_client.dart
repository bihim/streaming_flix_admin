import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:streaming_flix_admin/api/apis.dart';
import 'package:streaming_flix_admin/global/global_values.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: GlobalValues.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(Apis.videoAdd)
  Future<AddVideoModel> uploadVideo(
      @Field('name') String name,
      @Field('year') String year,
      @Field('description') String description,
      @Field('category') String category,
      @Field('image_link') String imageLink,
      @Field('is_featured') String isFeatured,
      @Field('is_uploaded') String isUploaded,
      @Field('file') MultipartFile file);
//Run the command: flutter pub run build_runner build
}

@JsonSerializable()
class AddVideoModel {
  AddVideoModel({
    this.status,
  });

  bool? status;

  factory AddVideoModel.fromJson(Map<String, dynamic> json) => _$AddVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddVideoModelToJson(this);
}

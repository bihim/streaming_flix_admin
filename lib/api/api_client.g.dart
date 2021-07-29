// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVideoModel _$AddVideoModelFromJson(Map<String, dynamic> json) {
  return AddVideoModel(
    status: json['status'] as bool?,
  );
}

Map<String, dynamic> _$AddVideoModelToJson(AddVideoModel instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= GlobalValues.baseUrl;
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AddVideoModel> uploadVideo(name, year, description, category,
      imageLink, isFeatured, isUploaded, file) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'name': name,
      'year': year,
      'description': description,
      'category': category,
      'image_link': imageLink,
      'is_featured': isFeatured,
      'is_uploaded': isUploaded,
      'file': file
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddVideoModel>(
            Options(method: 'POST', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/video/add',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddVideoModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

part of 'users_api.dart';

class _UsersApi implements UsersApi {
  _UsersApi(this._dio);

  final Dio _dio;

  final _headers = <String, dynamic>{
    "ApiKey": StorageKeys.apikey
  };

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

  @override
  Future<BaseResponse> getUserList({search="", take=15, skip=0}) async {
    const extra = <String, dynamic>{'token_required': false};
    final queryParameters = <String, dynamic>{
      "take": take,
      "skip": skip,
      "search": search
    };
    print(queryParameters);
    final headers = _headers;
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse>(Options(
            method: 'GET',
            headers: headers,
            extra: extra,
            contentType: 'text/plain')
            .compose(_dio.options, '/api/User',
            queryParameters: queryParameters, data: data)
            .copyWith(
            baseUrl: _dio.options.baseUrl)));
    print(result.data);
    return BaseResponse.fromJson(result.data!);
  }

  @override
  Future<BaseResponse> addUser(String name, String surname, String phone, String url) async {
    const extra = <String, dynamic>{'token_required': false};
    final queryParameters = <String, dynamic>{};
    final headers = _headers;
    final data = <String, dynamic>{
      "firstName": name,
      "lastName": surname,
      "phoneNumber": phone,
      "profileImageUrl": url
    };
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse>(Options(
            method: 'POST',
            headers: headers,
            extra: extra,
            contentType: 'application/json')
            .compose(_dio.options, '/api/User',
            queryParameters: queryParameters, data: data)
            .copyWith(
            baseUrl: _dio.options.baseUrl)));
    return BaseResponse.fromJson(result.data!);
  }

  @override
  Future<BaseResponse> patchUser(String id, String name, String surname, String phone, String url) async {
    const extra = <String, dynamic>{'token_required': false};
    final queryParameters = <String, dynamic>{};
    final headers = _headers;
    final data = <String, dynamic>{
      "firstName": name,
      "lastName": surname,
      "phoneNumber": phone,
      "profileImageUrl": url
    };
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse>(Options(
            method: 'PUT',
            headers: headers,
            extra: extra,
            contentType: 'application/json')
            .compose(_dio.options, '/api/User/$id',
            queryParameters: queryParameters, data: data)
            .copyWith(
            baseUrl: _dio.options.baseUrl)));
    return BaseResponse.fromJson(result.data!);
  }

  @override
  Future<BaseResponse> deleteUser(String id) async {
    const extra = <String, dynamic>{'token_required': false};
    final queryParameters = <String, dynamic>{};
    final headers = _headers;
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse>(Options(
            method: 'DELETE',
            headers: headers,
            extra: extra,
            contentType: 'application/json')
            .compose(_dio.options, '/api/User/$id',
            queryParameters: queryParameters, data: data)
            .copyWith(
            baseUrl: _dio.options.baseUrl)));
    return BaseResponse.fromJson(result.data!);
  }
}

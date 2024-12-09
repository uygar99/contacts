import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../data/models/base_response.dart';
import '../data/storage.dart';
part "users_api.g.dart";

abstract class UsersApi {
  factory UsersApi(Dio dio) = _UsersApi;

  @GET("api/User")
  Future<BaseResponse> getUserList({
    @Query('search') String? search,
    @Query('take') int? take,
    @Query('skip') int? skip,
  });
  @GET("api/User")
  Future<BaseResponse> addUser(
      @Field('firstName') String name,
      @Field('lastName') String surname,
      @Field('phone') String phone,
      @Field('imageUrl') String url
      );

  @PUT("api/User/{id}")
  Future<BaseResponse> patchUser(
      @Path('id') String id,
      @Field('firstName') String name,
      @Field('lastName') String surname,
      @Field('phone') String phone,
      @Field('imageUrl') String url
      );

  @GET("api/User/{id}")
  Future<BaseResponse> deleteUser(
      @Path('id') String id,
      );
}

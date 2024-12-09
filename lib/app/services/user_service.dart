import 'dart:convert';

import 'package:contacts/app/data/models/base_response.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/instance_manager.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import '../providers/users_api.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  final Dio _dio = Dio(
      BaseOptions(
        baseUrl:  "http://146.59.52.68:11235"
    )
  );
  late UsersApi _api;
  late String partnerId;

  @override
  void onInit() {
    configureProvider();
    super.onInit();
  }


  void configureProvider() {
    _api = UsersApi(_dio);
  }

  Future<BaseResponse> getUserList({search, take, skip}) async {
    try {
      var response = _api.getUserList(search: search, take: take, skip: skip);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return BaseResponse(success: false, messages: [], status: 0);
    }
  }

  Future<String> postPhoto(XFile? file) async {
    try {
      if(file == null) return "";
      var request = http.MultipartRequest("POST", Uri.parse("http://146.59.52.68:11235/api/User/UploadImage"));
      request.files.add(await http.MultipartFile.fromPath("image", file.path));
      var resp = await request.send().then((response) {
        if (response.statusCode == 200) return response;});
      if(resp != null){
        var response = await http.Response.fromStream(resp);
        return json.decode(response.body)["data"]["imageUrl"];
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  Future<BaseResponse> addUser(String name, String surname, String phone, String url) async {
    try {
      var response = _api.addUser(name,surname,phone, url);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return BaseResponse(success: false, messages: [], status: 0);
    }
  }

  Future<BaseResponse> patchUser(String id, String name, String surname, String phone, String url) async {
    try {
      var response = _api.patchUser(id, name, surname, phone, url);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return BaseResponse(success: false, messages: [], status: 0);
    }
  }

  Future<BaseResponse> deleteUser(String id) async {
    try {
      var response = _api.deleteUser(id);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return BaseResponse(success: false, messages: [], status: 0);
    }
  }
}
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:fahem_dashboard/core/error/exceptions.dart';
import 'package:fahem_dashboard/core/network/api_constants.dart';
import 'package:fahem_dashboard/data/models/static/base_model.dart';
import 'package:fahem_dashboard/domain/usecases/upload_file/upload_file_usecase.dart';
import 'package:http/http.dart' as http;

class HttpHelper {

  static Future<dynamic> getData({required String endPoint, Map<String, dynamic>? query, required String printErrorMessage}) async {
    try {
      String q = query == null ? '' : '?${query.entries.map((e) => '${e.key}=${e.value}').toList().join('&')}';
      http.Response response = await http.get(Uri.parse('${ApiConstants.baseUrl}$endPoint$q'));

      // debugPrint('Body:: ${response.body}', wrapWidth: 1024);
      if(response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        BaseModel base = BaseModel.fromJson(jsonData['base']);
        if(base.status) {
          return jsonData;
        }
        else {
          debugPrint('$printErrorMessage: ${base.messageEn}');
          throw ServerException(messageAr: base.messageAr, messageEn: base.messageEn);
        }
      }
      else {
        debugPrint('$printErrorMessage: ${response.statusCode} / ${response.reasonPhrase}');
        throw ServerException(messageAr: 'حدث خطأ أثناء الاتصال بالخادم', messageEn: 'An error occurred while connecting to the server');
      }
    }
    on ServerException catch(error) {
      throw ServerException(messageAr: error.messageAr, messageEn: error.messageEn);
    }
    catch(error) {
      debugPrint('$printErrorMessage: ${error.toString()}');
      throw ServerException(messageAr: 'حدث خطأ حاول مرة اخرى', messageEn: 'An error occurred try again');
    }
  }

  static Future<dynamic> postData({required String endPoint, Map<String, dynamic>? body, required String printErrorMessage}) async {
    try {
      http.Response response = await http.post(Uri.parse('${ApiConstants.baseUrl}$endPoint'), body: body);

      // debugPrint('Body:: ${response.body}', wrapWidth: 1024);
      if(response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(response.body);
        BaseModel base = BaseModel.fromJson(jsonData['base']);
        if(base.status) {
          return jsonData;
        }
        else {
          debugPrint('$printErrorMessage: ${base.messageEn}');
          throw ServerException(messageAr: base.messageAr, messageEn: base.messageEn);
        }
      }
      else {
        debugPrint('$printErrorMessage: ${response.statusCode} / ${response.reasonPhrase}');
        throw ServerException(messageAr: 'حدث خطأ أثناء الاتصال بالخادم', messageEn: 'An error occurred while connecting to the server');
      }
    }
    on ServerException catch(error) {
      throw ServerException(messageAr: error.messageAr, messageEn: error.messageEn);
    }
    catch(error) {
      debugPrint('$printErrorMessage: ${error.toString()}');
      throw ServerException(messageAr: 'حدث خطأ حاول مرة اخرى', messageEn: 'An error occurred try again');
    }
  }

  static Future<dynamic> uploadFile({required UploadFileParameters parameters}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest("POST", Uri.parse('${ApiConstants.baseUrl}${ApiConstants.uploadFileEndPoint}'));
      request.fields[ApiConstants.directoryField] = parameters.directory;
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(ApiConstants.fileField, parameters.file.path, contentType: MediaType('image', parameters.file.path.split('.').last));
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();

      if(response.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(String.fromCharCodes(await response.stream.toBytes()));
        BaseModel base = BaseModel.fromJson(jsonData['base']);
        if(base.status) {
          return jsonData;
        }
        else {
          debugPrint('uploadFileError: ${base.messageEn}');
          throw ServerException(messageAr: base.messageAr, messageEn: base.messageEn);
        }
      }
      else {
        debugPrint('uploadFileError: ${response.statusCode} / ${response.reasonPhrase}');
        throw ServerException(messageAr: 'حدث خطأ أثناء الاتصال بالخادم', messageEn: 'An error occurred while connecting to the server');
      }
    }
    on ServerException catch(error) {
      throw ServerException(messageAr: error.messageAr, messageEn: error.messageEn);
    }
    catch(error) {
      debugPrint('uploadFileError: ${error.toString()}');
      throw ServerException(messageAr: 'حدث خطأ حاول مرة اخرى', messageEn: 'An error occurred try again');
    }
  }
}
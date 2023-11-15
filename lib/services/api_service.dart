import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/api_model.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(
      baseUrl: "http://api.mediastack.com/v1/news?",
      queryParameters: {"access_key": "80bcddb6188e9762d9df36e58b4dd6a8"}));

  Future<ApiModel?> getAllNews() async {
    try {
      Response response = await dio.get('');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        var jsonResponse = jsonEncode(response.data);
        return apiModelFromJson(jsonResponse);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ApiModel?> getCountryNews() async {
    try {
      Response response = await dio.get('&countries=in');
      log("Country:${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonEncode(response.data);
        return apiModelFromJson(jsonResponse);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<ApiModel?> searchApi(String searchitem) async {
    try {
      Response response = await dio.get('&keywords=$searchitem');
      log("Search:${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonEncode(response.data);
        return apiModelFromJson(jsonResponse);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
final getAllNewsProvider = FutureProvider((ref) {
  return ref.watch(apiServiceProvider).getAllNews();
});
final getCountryNewsProvider = FutureProvider((ref) {
  return ref.watch(apiServiceProvider).getCountryNews();
});
final texteditingProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});
final searchNewsProvider = FutureProvider<ApiModel?>((ref) {
  var textController = ref.watch(texteditingProvider);
  if (textController.text == "") {
    return null;
  }
  return ref.watch(apiServiceProvider).searchApi(textController.text);
});

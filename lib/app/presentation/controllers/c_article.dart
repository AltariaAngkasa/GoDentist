import 'package:GoDentist/app/data/models/articles/article_response.dart';
import 'package:GoDentist/app/data/network/api_service.dart';
import 'package:GoDentist/app/presentation/controllers/c_common.dart';
import 'package:GoDentist/app/presentation/controllers/c_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CArticle extends CCommon {
  final apiService = ApiService();
  final cLogin = Get.put(CLogin());

  final Rx<ArticleResponse> _articleResponse = ArticleResponse().obs;
  ArticleResponse get articleResponse => _articleResponse.value;
  set articleResponse(ArticleResponse newValue) {
    _articleResponse.value = newValue;
  }

  final TextEditingController searchQuery = TextEditingController();

  Future getArticle() async {
    isFetching = true;
    final result = await apiService.getArticle();
    result.when(
      success: (data) {
        articleResponse = data;
        isSuccessfull = true;
        isFetching = false;

        message = articleResponse.message ?? "Successfull get article";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  Future searchArticle(String article) async {
    isFetching = true;
    final result = await apiService.searchArticle(article);
    result.when(
      success: (data) {
        articleResponse = data;
        isSuccessfull = true;
        isFetching = false;
        message = articleResponse.message ?? "Successfull search article";
      },
      failure: (error, stackTrace) {
        isSuccessfull = false;
        message = error.message;
        isFetching = false;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getArticle();
  }
}

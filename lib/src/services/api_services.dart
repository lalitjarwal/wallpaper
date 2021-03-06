import 'dart:convert';

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wallpaper/src/models.dart/search_result.dart';
import 'package:wallpaper/src/models.dart/trending.dart';
import 'package:wallpaper/src/services/cache.dart';
import 'package:wallpaper/src/utils/constants.dart';

class ApiManager {
  @protected
  static const String _baseURl = 'https://api.pexels.com/v1';
  @protected
  static const _headers = const {'Authorization': apiKey};

  // static bool firstResponse = true;
  static Trending trending = Trending();

  static Future<SearchResult> searchImage(String query) async {
    var _error = "";
    try {
      var response = await get(
          Uri.tryParse(
            _baseURl + "/search?query=$query&per_page=30",
          )!,
          headers: _headers);
      if (response.statusCode == 200) {
        print(response.body);
        return searchResultFromJson(response.body);
      } else {
        _error = jsonDecode(response.body)['error'];
        return SearchResult();
      }
    } on SocketException {
      Get.rawSnackbar(
          title: "Warning!", message: "Please check your internet connection!");
      return SearchResult();
    } on HttpException catch (exception) {
      Get.rawSnackbar(title: exception.message, message: _error);
      return SearchResult();
    } catch (e) {
      return SearchResult();
    }
  }

  @protected
  static Future<Trending> _getData() async {
    var _error = "";
    try {
      var response = await get(
          Uri.tryParse(
            _baseURl + "/curated?per_page=50",
          )!,
          headers: _headers);
      if (response.statusCode == 200) {
        Cache.putCache(response.body, DateTime.now().toIso8601String());
        trending = trendingFromJson(response.body);
        return trending;
      } else {
        _error = jsonDecode(response.body)['error'];
        return trending;
      }
    } on SocketException {
      Get.rawSnackbar(
          title: "Warning!", message: "Please check your internet connection!");
      return trending;
    } on HttpException catch (exception) {
      Get.rawSnackbar(title: exception.message, message: _error);
      return trending;
    } catch (e) {
      return trending;
    }
  }

  static Future<Trending> getTrending() async {
    Duration? duration = Duration.zero;
    if (Cache.checkCache('time')) {
      duration = DateTime.now()
          .difference(DateTime.tryParse(Cache.readCache('time'))!);
    }
    int comparison = duration.compareTo(Duration(hours: 1));
    if (!Cache.checkCache('trending')) {
      print("calling.....");
      return _getData();
    } else {
      if (comparison > 0) {
        print("Calling...!");
        return _getData();
      }
      print("calling from cache");
      return trendingFromJson(Cache.readCache('trending'));
    }
  }
}

import 'dart:convert';

import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wallpaper/src/models.dart/search_result.dart';
import 'package:wallpaper/src/models.dart/trending.dart';
import 'package:wallpaper/src/utils/constants.dart';

class ApiManager {
  static const String _baseURl = 'https://api.pexels.com/v1';
  static const _headers = const {'Authorization': apiKey};

  static bool firstResponse = true;
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

  static Future<Trending> getTrending() async {
    var _error = "";
    if (firstResponse) {
      print("calling.....");
      try {
        var response = await get(
            Uri.tryParse(
              _baseURl + "/curated?per_page=50",
            )!,
            headers: _headers);
        if (response.statusCode == 200) {
          trending = trendingFromJson(response.body);
          firstResponse = false;
          return trending;
        } else {
          _error = jsonDecode(response.body)['error'];
          return trending;
        }
      } on SocketException {
        Get.rawSnackbar(
            title: "Warning!",
            message: "Please check your internet connection!");
        return trending;
      } on HttpException catch (exception) {
        Get.rawSnackbar(title: exception.message, message: _error);
        return trending;
      } catch (e) {
        return trending;
      }
    } else {
      print("calling from cache");
      return trending;
    }
  }
}

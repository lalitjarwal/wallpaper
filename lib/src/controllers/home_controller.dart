import 'package:get/get.dart';
import 'package:wallpaper/src/models.dart/common.dart';
import 'package:wallpaper/src/views/search_result_view.dart';

class HomeController extends GetxController {
  var isCollapsed = true.obs;

  var photos = <Photo>[].obs;

  void performSearch({String? value}) {
    isCollapsed.toggle();
    Get.to(() => SearchResultsView(query: value!));
  }
}

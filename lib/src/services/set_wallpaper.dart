import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper/src/models.dart/common.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperService {
  static void setWallpaper(Photo image, int location) async {
    var directory = await getTemporaryDirectory();

    File _image =
        File(directory.path + DateTime.now().toIso8601String() + '.png');

    http.Response response = await http.get(Uri.tryParse(image.src!.large2X!)!);
    Get.back();
    _image.writeAsBytes(response.bodyBytes).then((value) =>
        WallpaperManager.setWallpaperFromFile(value.path, location)
            .then((value) => print(value)));
  }
}

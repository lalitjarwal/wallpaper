import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:share/share.dart';
import 'package:wallpaper/src/models.dart/common.dart';
import 'package:wallpaper/src/services/set_wallpaper.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.image, this.index})
      : super(key: key);
  final Photo image;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      extendBodyBehindAppBar: true,
      floatingActionButton:
          FabCircularMenu(ringColor: Colors.black26, children: [
        IconButton(
            tooltip: 'Info',
            onPressed: () {
              Get.defaultDialog(
                  title: "Photo Info",
                  content: buildInfo(),
                  confirm: OutlinedButton(
                      style:
                          OutlinedButton.styleFrom(primary: Colors.tealAccent),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Ok')));
            },
            icon: Icon(Icons.info)),
        IconButton(
            onPressed: () async {
              Get.bottomSheet(buildBottomSheet(context));
            },
            tooltip: 'Set As',
            icon: Icon(Icons.photo)),
        IconButton(
            onPressed: () => Share.share(
                  "Check this cool image by ${image.photographer} at ${image.url}"),
            tooltip: 'Share',
            icon: Icon(Icons.share))
      ]),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Hero(
          tag: index!,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: "${image.src!.large2X}",
              placeholder: (_, __) => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Container buildBottomSheet(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("Set as Wallpaper"),
          ),
          Divider(),
          ListTile(
            title: Text("Home Screen"),
            onTap: () => WallpaperService.setWallpaper(
                image, WallpaperManager.HOME_SCREEN),
          ),
          Divider(),
          ListTile(
            title: Text("Lock Screen"),
            onTap: () => WallpaperService.setWallpaper(
                image, WallpaperManager.LOCK_SCREEN),
          ),
          Divider(),
          ListTile(
            title: Text("Both Screens"),
            onTap: () => WallpaperService.setWallpaper(
                image, WallpaperManager.BOTH_SCREENS),
          ),
        ],
      ),
    );
  }

  Table buildInfo() {
    return Table(
      border: TableBorder.all(color: Colors.white, width: 2.0),
      children: [
        TableRow(decoration: BoxDecoration(color: Colors.black26), children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Photograph By:"),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(image.photographer!),
            ),
          )
        ]),
        TableRow(decoration: BoxDecoration(color: Colors.black26), children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Photograph ID:"),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(image.photographerId.toString()),
            ),
          )
        ]),
        TableRow(decoration: BoxDecoration(color: Colors.black26), children: [
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Credit:"),
            ),
          ),
          TableCell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(image.photographerUrl!),
            ),
          )
        ]),
      ],
    );
  }
}

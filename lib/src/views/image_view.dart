import 'package:cached_network_image/cached_network_image.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper/src/models.dart/common.dart';

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
              Get.defaultDialog(title: "Photo Info", content: buildInfo());
            },
            icon: Icon(Icons.info)),
        IconButton(
            onPressed: () {}, tooltip: 'Set As', icon: Icon(Icons.photo)),
        IconButton(onPressed: () {}, tooltip: 'Share', icon: Icon(Icons.share))
      ]),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: Hero(
          tag: index!,
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: "${image.src!.large2X}",
              placeholder: (_, __) => Center(
                child: CircularProgressIndicator(),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
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

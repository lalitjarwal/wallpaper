import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/src/controllers/home_controller.dart';
import 'package:wallpaper/src/models.dart/trending.dart';
import 'package:wallpaper/src/services/api_services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/src/utils/constants.dart';
import 'package:wallpaper/src/views/image_view.dart';
import 'package:wallpaper/src/views/search_result_view.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Wallpaper App'),
        actions: [buildSearch(context)],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: catagories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var entry = catagories.entries.toList()[index];
                return GestureDetector(
                  onTap: () =>Get.to(()=>SearchResultsView(query: entry.key)),
                  child: Container(
                    height: 46,
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        children: [
                          CachedNetworkImage(
                            imageUrl: entry.value,
                            color: Colors.black26,
                            colorBlendMode: BlendMode.multiply,
                            fit: BoxFit.fill,
                          ),
                          Center(child: Text(entry.key)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<Trending>(
              future: ApiManager.getTrending(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  // print(data.totalResults);
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: data.photos!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () => Get.to(() => ImageView(
                            image: data.photos![index],
                            index: index,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Hero(
                          tag: index,
                          child: CachedNetworkImage(
                            imageUrl: "${data.photos![index].src!.medium}",
                            placeholder: (_, __) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                        StaggeredTile.count(2, index.isEven ? 5 : 3),
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.tealAccent),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Obx buildSearch(BuildContext context) {
    return Obx(() {
      var size = MediaQuery.of(context).size;
      return AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        width: controller.isCollapsed.value ? 56 : size.width,
        height: controller.isCollapsed.value ? 56 : size.height,
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: !controller.isCollapsed.value
            ? TextField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                onSubmitted: (value) => controller.performSearch(value: value),
                decoration: InputDecoration(
                    filled: true,
                    contentPadding:
                        const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.tealAccent,
                      ),
                      onPressed: () => controller.isCollapsed.toggle(),
                    ),
                    hintText: 'Search Wallpaper'),
              )
            : IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => controller.isCollapsed.toggle(),
              ),
      );
    });
  }
}

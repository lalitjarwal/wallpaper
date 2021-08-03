import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallpaper/src/models.dart/search_result.dart';
import 'package:wallpaper/src/services/api_services.dart';
import 'package:wallpaper/src/views/image_view.dart';

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({Key? key, required this.query}) : super(key: key);
  final String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Search Results for '$query'"),
      ),
      body: FutureBuilder<SearchResult>(
        future: ApiManager.searchImage(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              padding: const EdgeInsets.all(8.0),
              itemCount: data.photos!.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

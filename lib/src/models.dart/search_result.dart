import 'dart:convert';

import 'package:wallpaper/src/models.dart/common.dart';


SearchResult searchResultFromJson(String str) => SearchResult.fromJson(json.decode(str));

String searchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
    SearchResult({
        this.page,
        this.perPage,
        this.photos,
        this.totalResults,
        this.nextPage,
    });

    final int? page;
    final int? perPage;
    final List<Photo>? photos;
    final int? totalResults;
    final String? nextPage;

    factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        page: json["page"],
        perPage: json["per_page"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
    };
}
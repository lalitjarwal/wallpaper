// To parse this JSON data, do
//
//     final trending = trendingFromJson(jsonString?);

import 'dart:convert';

import 'package:wallpaper/src/models.dart/common.dart';

Trending trendingFromJson(String? str) => Trending.fromJson(json.decode(str!));

String? trendingToJson(Trending data) => json.encode(data.toJson());

class Trending {
    Trending({
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

    factory Trending.fromJson(Map<String?, dynamic> json) => Trending(
        page: json["page"],
        perPage: json["per_page"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        totalResults: json["total_results"],
        nextPage: json["next_page"],
    );

    Map<String?, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
    };
}


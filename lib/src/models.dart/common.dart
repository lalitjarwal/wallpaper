
class Photo {
    Photo({
        this.id,
        this.width,
        this.height,
        this.url,
        this.photographer,
        this.photographerUrl,
        this.photographerId,
        this.avgColor,
        this.src,
        this.liked,
    });

    final int? id;
    final int? width;
    final int? height;
    final String? url;
    final String? photographer;
    final String? photographerUrl;
    final int? photographerId;
    final String? avgColor;
    final Src? src;
    final bool? liked;

    factory Photo.fromJson(Map<String?, dynamic> json) => Photo(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographer_url"],
        photographerId: json["photographer_id"],
        avgColor: json["avg_color"],
        src: Src.fromJson(json["src"]),
        liked: json["liked"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "url": url,
        "photographer": photographer,
        "photographer_url": photographerUrl,
        "photographer_id": photographerId,
        "avg_color": avgColor,
        "src": src!.toJson(),
        "liked": liked,
    };
}

class Src {
    Src({
        this.original,
        this.large2X,
        this.large,
        this.medium,
        this.small,
        this.portrait,
        this.landscape,
        this.tiny,
    });

    final String? original;
    final String? large2X;
    final String? large;
    final String? medium;
    final String? small;
    final String? portrait;
    final String? landscape;
    final String? tiny;

    factory Src.fromJson(Map<String?, dynamic> json) => Src(
        original: json["original"],
        large2X: json["large2x"],
        large: json["large"],
        medium: json["medium"],
        small: json["small"],
        portrait: json["portrait"],
        landscape: json["landscape"],
        tiny: json["tiny"],
    );

    Map<String?, dynamic> toJson() => {
        "original": original,
        "large2x": large2X,
        "large": large,
        "medium": medium,
        "small": small,
        "portrait": portrait,
        "landscape": landscape,
        "tiny": tiny,
    };
}
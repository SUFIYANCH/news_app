// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  Pagination pagination;
  List<Datum> data;

  ApiModel({
    required this.pagination,
    required this.data,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String? author;
  String title;
  String description;
  String url;
  String source;
  String? image;
  String category;
  String language;
  String country;
  DateTime publishedAt;

  Datum({
    this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.source,
    this.image,
    required this.category,
    required this.language,
    required this.country,
    required this.publishedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        source: json["source"],
        image: json["image"],
        category: json["category"],
        language: json["language"],
        country: json["country"],
        publishedAt: DateTime.parse(json["published_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "source": source,
        "image": image,
        "category": category,
        "language": language,
        "country": country,
        "published_at": publishedAt.toIso8601String(),
      };
}

class Pagination {
  int limit;
  int offset;
  int count;
  int total;

  Pagination({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "count": count,
        "total": total,
      };
}

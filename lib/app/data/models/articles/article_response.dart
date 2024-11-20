class ArticleResponse {
  bool? status;
  String? message;
  List<Datum>? data;

  ArticleResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? title;
  String? description;
  String? source;
  String? photoUrl;
  DateTime? createdAt;
  Author? author;
  Author? category;

  Datum({
    this.id,
    this.title,
    this.description,
    this.source,
    this.photoUrl,
    this.createdAt,
    this.author,
    this.category,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        source: json["source"],
        photoUrl: json["photoURL"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        category:
            json["category"] == null ? null : Author.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "source": source,
        "photoURL": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "author": author?.toJson(),
        "category": category?.toJson(),
      };
}

class Author {
  String? name;

  Author({
    this.name,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

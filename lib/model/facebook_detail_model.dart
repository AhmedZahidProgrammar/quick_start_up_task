import 'dart:convert';

FacebookDetailModel facebookDetailModelFromJson(String str) =>
    FacebookDetailModel.fromJson(json.decode(str));

String facebookDetailModelToJson(FacebookDetailModel data) =>
    json.encode(data.toJson());

class FacebookDetailModel {
  FacebookDetailModel({
    required this.name,
    required this.email,
    required this.picture,
    required this.id,
  });

  final String name;
  final String email;
  final Picture picture;
  final String id;

  factory FacebookDetailModel.fromJson(Map<String, dynamic> json) =>
      FacebookDetailModel(
        name: json["name"],
        email: json["email"],
        picture: Picture.fromJson(json["picture"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "picture": picture.toJson(),
        "id": id,
      };
}

class Picture {
  Picture({
    required this.data,
  });

  final Data data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.height,
    required this.isSilhouette,
    required this.url,
    required this.width,
  });

  final int height;
  final bool isSilhouette;
  final String url;
  final int width;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        height: json["height"],
        isSilhouette: json["is_silhouette"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "is_silhouette": isSilhouette,
        "url": url,
        "width": width,
      };
}

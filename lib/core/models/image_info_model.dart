// To parse this JSON data, do
//
//     final imageInfoModel = imageInfoModelFromJson(jsonString);

import 'dart:convert';

class ImageInfoModel {
  ImageInfoModel({
    required this.contrast,
    required this.img,
    required this.rotation,
    required this.sf,
  });

  double contrast;
  String img;
  int rotation;
  int sf;

  factory ImageInfoModel.fromRawJson(String str) =>
      ImageInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageInfoModel.fromJson(Map<String, dynamic> json) => ImageInfoModel(
        contrast: json["contrast"].toDouble(),
        img: json["img"],
        rotation: json["rotation"],
        sf: json["sf"],
      );

  Map<String, dynamic> toJson() => {
        "contrast": contrast,
        "img": img,
        "rotation": rotation,
        "sf": sf,
      };
}

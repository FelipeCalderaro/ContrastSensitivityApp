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
  double rotation;
  int sf;

  factory ImageInfoModel.fromRawJson(String str) =>
      ImageInfoModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory ImageInfoModel.fromJson(Map<String, dynamic> json) => ImageInfoModel(
        contrast: json["contrast"].toDouble() as double,
        img: json["img"].toString(),
        rotation: double.parse(json["rotation"].toString()),
        sf: int.parse(json["sf"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "contrast": contrast,
        "img": img,
        "rotation": rotation,
        "sf": sf,
      };
}

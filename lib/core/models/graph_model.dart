// To parse this JSON data, do
//
//     final graphModel = graphModelFromJson(jsonString);

import 'dart:convert';

class GraphModel {
  GraphModel({
    required this.contrastThreshold,
    required this.graph,
    required this.sensitivity,
  });

  double contrastThreshold;
  String graph;
  double sensitivity;
  factory GraphModel.fromRawJson(String str) =>
      GraphModel.fromJson(json.decode(str) as Map<String, dynamic>);

  String toRawJson() => json.encode(toJson());

  factory GraphModel.fromJson(Map<String, dynamic> json) => GraphModel(
        contrastThreshold: double.parse(json["contrastThreshold"].toString()),
        graph: json["graph"].toString(),
        sensitivity: double.parse(json["sensitivity"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "contrastThreshold": contrastThreshold,
        "graph": graph,
        "sensitivity": sensitivity,
      };
}

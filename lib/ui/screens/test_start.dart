// import 'dart:convert';

// import 'package:adeptus_vision/core/models/image_info_model.dart';
// import 'package:adeptus_vision/core/services/cs_api.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   String? imageBytes;
//   bool loading = true;
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           var a = await ConstrastSensitivityAPI().getImage();
//           if (a is ImageInfoModel) {
//             setState(() {
//               widget.imageBytes = a.imageBytes;
//               print(a.imageBytes);
//               widget.loading = false;
//             });
//           }
//         },
//       ),
//       body: widget.loading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : Center(
//               child: Image.memory(Base64Decoder().convert(widget.imageBytes!)),
//             ),
//       // : Center(
//       //     child: Text(widget.imageBytes!),
//       // ),
//     );
//   }
// }

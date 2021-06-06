import 'dart:typed_data';

import 'package:adeptus_vision/core/view_models/main_view_model.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class PDFViewerScreen extends StatelessWidget {
  final String type;
  const PDFViewerScreen({
    Key? key,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: mainViewModel.generatePDF(type),
        builder: (context, AsyncSnapshot<Uint8List> snapshot) {
          print(snapshot.error);
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .87,
                  child: PDFView(
                    pdfData: snapshot.data,
                    pageFling: false,
                    pageSnap: false,
                    onError: (error) => print(error),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // final a = {
                    //   0: 'left',
                    //   1: 'right',
                    //   2: 'both',
                    // };
                    // var testsCompleted = false;
                    // for (var i = 0; i < 3; i++) {
                    //   testsCompleted =
                    //       testViewModel.answers[a[i]]?.isNotEmpty ?? false;
                    // }
                    // if (testsCompleted) {
                    //   mainViewModel.sharePDF(snapshot.data!);
                    // } else {
                    Navigator.pop(context);
                    // }
                  },
                  child: Text(
                    "Finalizar",
                    style: AppTextStyles.regular,
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

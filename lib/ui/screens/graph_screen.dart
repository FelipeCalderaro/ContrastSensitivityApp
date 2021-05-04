import 'dart:convert';

import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: testViewModel.graphinfo == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Image.memory(
                Base64Decoder().convert(testViewModel.graphinfo!.graph),
              ),
            ),
    );
  }
}

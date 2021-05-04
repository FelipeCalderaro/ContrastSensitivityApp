import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/graph_screen.dart';
import 'package:adeptus_vision/ui/screens/image_screen.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              testViewModel.reset();
              testViewModel.requestTestImageAndInfo(
                CSV_1000E_STANDART[0],
                DEFAULT_START_CONTRAST,
              );
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (BuildContext context) => ImageScreen(),
                ),
              );
            },
            child: Text('Start Test'),
          ),
          ElevatedButton(
            onPressed: () {
              testViewModel.generateGraphAndResults(3);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (BuildContext context) => GraphScreen(),
                ),
              );
            },
            child: Text('Gerar grafico'),
          ),
        ],
      ),
    );
  }
}

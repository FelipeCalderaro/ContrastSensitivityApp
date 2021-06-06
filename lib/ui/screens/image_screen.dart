import 'dart:convert';
import 'dart:ui';

import 'package:adeptus_vision/core/models/test_image_sequence.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/graph_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatefulWidget {
  final String selectedTestType;
  const ImageScreen({
    Key? key,
    required this.selectedTestType,
  }) : super(key: key);
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final PageController controller = PageController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    Future.delayed(
      const Duration(milliseconds: 400),
      () => TestViewModel.instance().reset(),
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xffD2D2D2),
      // appBar: AppBar(),
      body: PageView(
        controller: controller,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    // child: Image.memory(
                    //   const Base64Decoder()
                    //       .convert(testViewModel.imageInfos!.img),
                    //   color: Colors.grey.withOpacity(.3),
                    //   colorBlendMode: BlendMode.colorDodge,
                    // ),
                    child: Image.asset(
                      testViewModel.currentImagePath,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * .1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(DEFAULT_PADDING / 2),
                  child: Row(
                    children: const [
                      Text(
                        'Deslize para a direita para acessar os botões',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
              // Positioned.fill(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              //     child: Container(
              //       color: Colors.black.withOpacity(0),
              //     ),
              //   ),
              // )
            ],
          ),
          // Center(
          //   child: Text(testViewModel.imageInfos!.img),
          // ),
          Center(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(DEFAULT_PADDING * 2),
              childAspectRatio: 20 / 9,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => onTap(testViewModel, 'center'),
                    child: const Icon(
                      Icons.arrow_upward,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => onTap(testViewModel, 'right'),
                    child: const Icon(
                      Icons.arrow_forward,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => onTap(testViewModel, 'left'),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => onTap(testViewModel, 'none'),
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: const Text(
                        'Vazio',
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      // : Center(
      //     child: Text(widget.imageBytes!),
      // ),
    );
  }

  void onTap(TestViewModel testViewModel, String buttonClicked) {
    testViewModel.calculateHits(
      buttonClicked,
      widget.selectedTestType,
    );
    if (testViewModel.testeImages[widget.selectedTestType]!.length >=
        TestImageInfoSequence.rotation.length) {
      testViewModel.generateGraphAndResults(
        TestImageInfoSequence.grating,
        widget.selectedTestType,
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => GraphScreen(
            type: widget.selectedTestType,
          ),
        ),
      );
    }
    controller.animateToPage(0,
        duration: const Duration(milliseconds: 230), curve: Curves.bounceInOut);
  }
}

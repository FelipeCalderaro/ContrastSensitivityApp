import 'dart:convert';
import 'dart:ui';

import 'package:adeptus_vision/core/models/image_info_model.dart';
import 'package:adeptus_vision/core/services/cs_api.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/graph_screen.dart';
import 'package:adeptus_vision/ui/screens/home.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatelessWidget {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffD2D2D2),
      // appBar: AppBar(),
      body: testViewModel.imageInfos == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PageView(
              controller: controller,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image.memory(
                            Base64Decoder()
                                .convert(testViewModel.imageInfos!.img),
                            color: Colors.grey.withOpacity(.3),
                            colorBlendMode: BlendMode.colorDodge,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height * .1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(DEFAULT_PADDING / 2),
                        child: Row(
                          children: [
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
                    padding: EdgeInsets.all(DEFAULT_PADDING * 2),
                    childAspectRatio: 20 / 9,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('center');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length >=
                                MAX_NUMBER_OF_TESTS) {
                              testViewModel.generateGraphAndResults(
                                  testViewModel.currentCycle!);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => GraphScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(
                            Icons.arrow_upward,
                            size: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('right');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length >=
                                MAX_NUMBER_OF_TESTS) {
                              testViewModel.generateGraphAndResults(
                                  testViewModel.currentCycle!);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => GraphScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(
                            Icons.arrow_forward,
                            size: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('left');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length >=
                                MAX_NUMBER_OF_TESTS) {
                              testViewModel.generateGraphAndResults(
                                  testViewModel.currentCycle!);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => GraphScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('None');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length >=
                                MAX_NUMBER_OF_TESTS) {
                              testViewModel.generateGraphAndResults(
                                  testViewModel.currentCycle!);
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => GraphScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Container(
                            width: 200,
                            alignment: Alignment.center,
                            child: Text(
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
}

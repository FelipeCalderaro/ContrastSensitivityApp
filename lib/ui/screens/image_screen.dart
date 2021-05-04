import 'dart:convert';
import 'dart:ui';

import 'package:adeptus_vision/core/models/image_info_model.dart';
import 'package:adeptus_vision/core/services/cs_api.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/home.dart';
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
      appBar: AppBar(),
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
                    Positioned(
                      top: MediaQuery.of(context).size.height * .7,
                      child:
                          Text('Deslize para a direita para acessar os botões'),
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
                    padding: EdgeInsets.all(DEFAULT_PADDING),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('center');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length ==
                                MAX_NUMBER_OF_TESTS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(Icons.arrow_upward),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('right');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length ==
                                MAX_NUMBER_OF_TESTS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('left');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length ==
                                MAX_NUMBER_OF_TESTS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            testViewModel.calculateHits('None');
                            if (testViewModel
                                    .testeImages[testViewModel.currentCycle]!
                                    .length ==
                                MAX_NUMBER_OF_TESTS) {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            }
                            controller.animateToPage(0,
                                duration: Duration(milliseconds: 230),
                                curve: Curves.bounceInOut);
                          },
                          child: Container(
                            width: 60,
                            child: Text('Não vejo linhas ou Não sei dizer'),
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

import 'dart:convert';

import 'package:adeptus_vision/core/view_models/main_view_model.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/dashboard_screen/widgets/custom_button.dart';
import 'package:adeptus_vision/ui/screens/pdf_viewer_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphScreen extends StatelessWidget {
  final String type;

  const GraphScreen({
    Key? key,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: testViewModel.graphinfo == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Gerando gráfico, aguarde alguns instantes'),
                  SizedBox(
                    height: DEFAULT_PADDING,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(DEFAULT_PADDING),
                child: Column(
                  children: [
                    Text(
                      'Resultado do teste atual',
                      style: AppTextStyles.callout,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      child: Image.memory(
                        const Base64Decoder()
                            .convert(testViewModel.graphinfo!.graph),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomButton(
                              icon: Icons.next_plan,
                              text: 'Proximo teste',
                              color: AppColors.secondaryColor,
                              onTap: () {
                                // final a = {
                                //   0: 'left',
                                //   1: 'right',
                                //   2: 'both',
                                // };
                                // var testsCompleted = false;
                                // for (var i = 0; i < 3; i++) {
                                //   testsCompleted =
                                //       testViewModel.answers[a[i]]?.isNotEmpty ??
                                //           false;
                                // }
                                // if (testsCompleted) {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           const PDFViewerScreen(type: 'all'),
                                //     ),
                                //   );
                                // } else {
                                Navigator.pop(context);
                              }
                              // },
                              ),
                          CustomButton(
                            icon: Icons.graphic_eq,
                            text: 'Ver resultados detalhados',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PDFViewerScreen(type: type),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

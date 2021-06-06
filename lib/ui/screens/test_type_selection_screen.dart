import 'package:adeptus_vision/core/models/test_image_sequence.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/dashboard_screen/widgets/custom_button.dart';
import 'package:adeptus_vision/ui/screens/image_screen.dart';
import 'package:adeptus_vision/ui/screens/pdf_viewer_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(DEFAULT_PADDING),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/Eyes.gif',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              child: Text(
                'Selecione um teste para começar',
                style: AppTextStyles.callout,
                textAlign: TextAlign.center,
              ),
            ),
            CustomButton(
              icon: Icons.arrow_back,
              text: 'Olho esquerdo',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      testViewModel.testeImages['left']!.length >=
                              TestImageInfoSequence.rotation.length
                          ? const PDFViewerScreen(
                              type: 'left',
                            )
                          : const ImageScreen(
                              selectedTestType: 'left',
                            ),
                ),
              ),
            ),
            CustomButton(
              icon: Icons.arrow_forward,
              text: 'Olho direito',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        testViewModel.testeImages['right']!.length >=
                                TestImageInfoSequence.rotation.length
                            ? const PDFViewerScreen(
                                type: 'right',
                              )
                            : const ImageScreen(
                                selectedTestType: 'right',
                              ),
                  ),
                );
              },
            ),
            CustomButton(
              icon: CupertinoIcons.eye,
              text: 'Ambos',
              color: AppColors.secondaryColor,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        testViewModel.testeImages['both']!.length >=
                                TestImageInfoSequence.rotation.length
                            ? const PDFViewerScreen(
                                type: 'both',
                              )
                            : const ImageScreen(
                                selectedTestType: 'both',
                              ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

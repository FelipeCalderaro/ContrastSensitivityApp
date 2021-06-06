import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:adeptus_vision/ui/screens/form_screen.dart';
import 'package:adeptus_vision/ui/screens/image_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisclaimerPage extends StatefulWidget {
  @override
  _DisclaimerPageState createState() => _DisclaimerPageState();
}

class _DisclaimerPageState extends State<DisclaimerPage> {
  bool showButton = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        showButton = true;
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final testViewModel = Provider.of<TestViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DEFAULT_PADDING),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Atenção\n',
                style: AppTextStyles.callout.copyWith(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text:
                        'Este aplicativo é focado no uso profissional e não tem como intuito substituir o exame médico CVS-1000',
                    style: AppTextStyles.regular.copyWith(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            if (showButton) const SizedBox(height: 100),
            if (showButton)
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // testViewModel.requestTestImageAndInfo();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Continuar',
                    style: AppTextStyles.regular.copyWith(color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

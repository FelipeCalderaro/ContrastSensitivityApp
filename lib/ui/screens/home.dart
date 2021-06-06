import 'package:adeptus_vision/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 0,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width,
                color: AppColors.primaryColor,
                padding: const EdgeInsets.only(
                  top: DEFAULT_PADDING * 2,
                  right: DEFAULT_PADDING * 2,
                  left: DEFAULT_PADDING * 2,
                ),
                child: Image.asset(
                  'assets/images/animated_intro_image.gif',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sensibilidade ao contraste",
                    style: AppTextStyles.callout),
                const SizedBox(
                  height: DEFAULT_PADDING,
                ),
                Text(
                  "Vamos testar sua visão?",
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(
                  height: DEFAULT_PADDING * 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DEFAULT_PADDING,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .85,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Começar',
                        style: AppTextStyles.buttonText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Always starts on 0,0 and it is on top left corner
    // top to bottom in the left side
    path.lineTo(0, size.height * 0.8);

    // bottom line
    path.cubicTo(
      size.width * 0.25,
      size.height,
      size.width * 0.75,
      size.height,
      size.width,
      size.height * 0.8,
    );

    // bottom to top in the right side
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

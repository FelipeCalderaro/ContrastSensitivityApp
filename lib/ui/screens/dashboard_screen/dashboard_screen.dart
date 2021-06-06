import 'package:adeptus_vision/ui/screens/dashboard_screen/widgets/custom_button.dart';
import 'package:adeptus_vision/ui/screens/disclaimer_page.dart';
import 'package:adeptus_vision/ui/screens/form_screen.dart';
import 'package:adeptus_vision/ui/screens/instructions_screen.dart';
import 'package:adeptus_vision/ui/screens/pdf_viewer_screen.dart';
import 'package:adeptus_vision/ui/values/colors.dart';
import 'package:adeptus_vision/ui/values/styles.dart';
import 'package:adeptus_vision/ui/values/values.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height * .17,
            left: MediaQuery.of(context).size.width * .1,
            child: Text(
              'O que faremos hoje?',
              style: AppTextStyles.title.copyWith(color: Colors.white),
            ),
          ),
          DraggableScrollableSheet(
            minChildSize: 0.75,
            maxChildSize: 0.75,
            initialChildSize: .75,
            builder: (context, scrollController) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                top: DEFAULT_PADDING * 2,
                left: DEFAULT_PADDING,
                right: DEFAULT_PADDING,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  CustomButton(
                    color: AppColors.secondaryColor,
                    text: 'Iniciar Teste',
                    icon: Icons.pending,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisclaimerPage(),
                        ),
                      );
                    },
                  ),
                  CustomButton(
                    text: 'Instruções',
                    icon: Icons.info,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionsScreen(),
                        ),
                      );
                    },
                  ),
                  // CustomButton(
                  //   text: 'Informações',
                  //   icon: Icons.access_alarm,
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

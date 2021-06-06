import 'package:adeptus_vision/core/view_models/main_view_model.dart';
import 'package:adeptus_vision/core/view_models/test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:adeptus_vision/ui/screens/home.dart';
import 'package:flutter/services.dart';
// import 'package:adeptus_vision/ui/values/routes.dart' as Routes;
import 'package:provider/provider.dart';

import 'ui/values/strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainViewModel>(
          create: (context) => MainViewModel.instance(),
        ),
        ChangeNotifierProvider<TestViewModel>(
          create: (context) => TestViewModel.instance(),
        ),
      ],
      child: MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: HomeScreen(),
      ),
    );

    // return MaterialApp(
    //   title: APP_NAME,
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(primarySwatch: Colors.deepPurple),
    //   routes: Routes.routes,
    //   home: HomeScreen(),
    // );
  }
}

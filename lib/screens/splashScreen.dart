import 'package:flutter/material.dart';
import 'package:intelligent_inno_task/screens/userLocalPage.dart';
import 'package:intelligent_inno_task/utils/colors.dart';
import 'package:intelligent_inno_task/utils/margins.dart';
import 'package:intelligent_inno_task/utils/navigationUtil.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  @override
  // ignore: override_on_non_overriding_member
  void load() async {
    await Future.delayed(Duration(seconds: 3), () {
      navigateReplace(context, HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/bg.jpg'),
                ),
              ),
            ),
          ),
          const YMargin(10),
        ],
      ),
    );
  }
}

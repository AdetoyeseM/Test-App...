import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_inno_task/models/userHiveModel.dart';
import 'package:intelligent_inno_task/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:intelligent_inno_task/core/providers/providers.dart';
import 'package:intelligent_inno_task/screens/splashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  // Hive.registerAdapter(UserHiveListAdapter());
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    overrideDeviceColors();
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'esusuPAY',
        theme: context.themeData,
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

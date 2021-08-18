import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intelligent_inno_task/utils/colors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: Card(
          elevation: 5,
          child: Container(
            height: 80,
            width: 80,
            child: SpinKitPouringHourglass(color: accentColor, size: 50.0),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oracle/shared/constants.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: Center(
        child: SpinKitChasingDots(
          color: tertiaryColor,
          size: 100.0
        ),
      )
    );
  }
}

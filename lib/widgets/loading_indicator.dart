import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:search_gifs_http_flutter/const/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Center(
        child: LoadingIndicator(
          indicatorType: Indicator.ballTrianglePathColoredFilled,
          colors: gradientColors,
          strokeWidth: 2,
          pathBackgroundColor: Colors.black,
        ),
      ),
    );
  }
}

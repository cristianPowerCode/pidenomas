import 'package:flutter/material.dart';

import '../general/colors.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDefaultIconDarkColor.withOpacity(0.85),
      child: Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            color: kBrandPrimaryColor1,
            strokeWidth: 5,
          ),
        ),
      ),
    );
  }
}

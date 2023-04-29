import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 50,
      child: Lottie.asset(
        "assets/lottie/no_data2.json",
      ),
    );
  }
}

import 'package:app_excle/core/resources/assets_fonts.dart';
import 'package:app_excle/core/resources/size_config.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({super.key, this.isBack = false});
  bool? isBack;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isBack!
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  : const SizedBox(),
              isBack!
                  ? const SizedBox()
                  : SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "College of Computer Science & Information Systems",
                            style: TextStyle(
                              fontFamily: AssetsFonts.regular,
                            ),
                          ),
                          Text(
                            "Najran University",
                          ),
                        ],
                      ),
                    ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Image.asset(
                    "assets/images/logo2.png",
                    height: SizeConfig.blockSizeVertical! * 10,
                  ),
                ),
              ),
              
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}



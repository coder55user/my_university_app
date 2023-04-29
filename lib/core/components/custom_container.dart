import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    this.child,
    this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.onTap,
  });
  Widget? child;
  String? image;
  double? height;
  double? width;
  double? borderRadius;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Container(
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(borderRadius ?? 20),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  image!,
                ),
              ),
            ),
          ),
          Container(
            height: height ?? double.infinity,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.grey.withOpacity(0.0),
                  Colors.black,
                ],
                stops: [0.0, 1.0],
              ),
            ),
            child: child,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenUtilHelper {
  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  static double get screenWidth => 1.sw;
  static double get screenHeight => 1.sh;
  static double get statusBarHeight => ScreenUtil().statusBarHeight;
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;
  
  static double setWidth(double width) => width.w;
  static double setHeight(double height) => height.h;
  static double setRadius(double radius) => radius.r;
  static double setFontSize(double fontSize) => fontSize.sp;
  
  static Widget verticalSpace(double height) => SizedBox(height: height.h);
  static Widget horizontalSpace(double width) => SizedBox(width: width.w);
}

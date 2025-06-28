import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constant/appcolors.dart';
import '../constant/text.dart';

Widget appbar(
    BuildContext context, {
      required String title,
      VoidCallback? onBackTap,
      VoidCallback? onMenuTap,
      bool showBackIcon = false,
      bool showMenuIcon = false,
      bool showNotificationIcon = true,
    }) {
  return Container(
    height: 7.h,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(15),
      ),
      color: AppColors.appbarcolor,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    ),
    child: Row(
      children: [
        if (showBackIcon)
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: GestureDetector(
              onTap: onBackTap ?? () => Navigator.pop(context),
              child: Container(
                height: 4.5.h,
                width: 9.5.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.arrow_back, color: Colors.black, size: 6.w),
                ),
              ),
            ),
          )
        else if (showMenuIcon)
          Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: GestureDetector(
              onTap: onMenuTap ?? () {},
              child: Container(
                height: 4.5.h,
                width: 9.5.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(Icons.menu, color: Colors.black, size: 6.w),
                ),
              ),
            ),
          )
        else
          SizedBox(width: 8.w),
        Expanded(
          child: titleSmall(
            title,
            18.sp,
            TextAlign.center,
            Colors.black,
            FontWeight.bold,
          ),
        ),
        if (showNotificationIcon)
          Padding(
            padding: EdgeInsets.only(right: 6.w),
            child: Icon(CupertinoIcons.bell_circle, color: Colors.green, size: 10.w),
          )
        else
          SizedBox(width: 14.w),
      ],
    ),
  );
}


Widget titleSmall(
    String title,
    double fz,
    TextAlign align,
    Color clr,
    FontWeight fw, {
      int? maxLines,
      TextDecoration? decoration,
      Color? decorationColor,
    }) {
  return Text(
    title,
    textAlign: align,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontSize: fz,
      color: clr,
      fontWeight: fw,
      fontFamily: TextConstants.fontFamily,
      decoration: decoration,
      decorationColor: decorationColor,
    ),
  );
}
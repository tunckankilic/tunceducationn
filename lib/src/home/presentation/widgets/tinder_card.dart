import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TinderCard extends StatelessWidget {
  const TinderCard({required this.isFirst, super.key, this.colour});

  final bool isFirst;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 137,
      padding: EdgeInsets.only(left: 20.r),
      decoration: BoxDecoration(
        gradient: isFirst
            ? LinearGradient(
                colors: [Color(0xFF8E96FF), Color(0xFFA06AF9)],
              )
            : null,
        color: colour,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.15),
            offset: Offset(0, 4.w),
          ),
        ],
      ),
      child: isFirst
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${context.courseOfTheDay?.title ?? 'Chemistry'} '
                  'final\nexams',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
                Row(
                  children: [
                    Icon(IconlyLight.notification, color: Colors.white),
                    SizedBox(width: 8.w),
                    Text(
                      '45 minutes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : null,
    );
  }
}

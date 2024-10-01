import 'package:flutter/material.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.sectionTitle,
    required this.seeAll,
    required this.onSeeAll,
    super.key,
  });

  final String sectionTitle;
  final bool seeAll;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (seeAll)
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: onSeeAll,
            child: const Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colours.primaryColour,
              ),
            ),
          ),
      ],
    );
  }
}

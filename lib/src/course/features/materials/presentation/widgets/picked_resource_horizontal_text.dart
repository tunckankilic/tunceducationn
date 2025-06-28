import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickedResourceHorizontalText extends StatelessWidget {
  const PickedResourceHorizontalText({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

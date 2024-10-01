// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tunceducationn/core/extensions/context_extension.dart';

class NotFoundText extends StatelessWidget {
  final TextAlign textAlign;
  final double fontSize;

  final String text;
  const NotFoundText({
    super.key,
    required this.textAlign,
    required this.fontSize,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

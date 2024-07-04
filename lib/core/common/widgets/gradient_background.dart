import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    required this.child,
    required this.image,
    super.key,
  });

  final Widget child;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        // image: DecorationImage(
        //   image: AssetImage(image),
        //   fit: BoxFit.cover,
        // ),
        gradient: LinearGradient(
          colors: [
            Colors.blue[900]!,
            Colors.black,
            Colors.red[900]!,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}

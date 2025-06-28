import 'package:flutter/material.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return context.pop();
        } else {
          return;
        }
      },
      child: IconButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
        icon: Theme.of(context).platform == TargetPlatform.iOS
            ? const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )
            : const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
      ),
    );
  }
}

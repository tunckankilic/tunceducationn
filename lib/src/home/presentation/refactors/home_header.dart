import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/src/home/presentation/widgets/tinder_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Stack(
        children: [
          Text(
            'Hello\n${context.watch<UserProvider>().user!.fullName}',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.red[900]!),
          ),
          Positioned(
            top: context.height >= 926.h
                ? -25.h
                : context.height >= 844.h
                    ? -6.h
                    : context.height <= 800.h
                        ? 10.h
                        : 10.h,
            right: -14.r,
            child: const TinderCards(),
          ),
        ],
      ),
    );
  }
}

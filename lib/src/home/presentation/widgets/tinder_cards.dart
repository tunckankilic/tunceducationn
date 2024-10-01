import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/media_res.dart';
import 'package:tunceducationn/src/home/presentation/widgets/tinder_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TinderCards extends StatefulWidget {
  const TinderCards({super.key});

  @override
  State<TinderCards> createState() => _TinderCardsState();
}

class _TinderCardsState extends State<TinderCards>
    with TickerProviderStateMixin {
  final CardController cardController = CardController();

  int totalCards = 10;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.width,
        width: context.width,
        child: TinderSwapCard(
          totalNum: totalCards,
          cardController: cardController,
          swipeEdge: 4,
          maxWidth: context.width,
          maxHeight: context.width * .9,
          minWidth: context.width * .71,
          minHeight: context.width * .85,
          allowSwipe: false,
          swipeUpdateCallback:
              (DragUpdateDetails details, Alignment alignment) {
            // Get card alignment
            if (alignment.x < 0) {
              setState(() {
                totalCards - 1;
              });
            } else if (alignment.x > 0) {
              setState(() {
                totalCards - 1;
              });
            }
          },
          swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
            // if the card was the last card, add more cards to be swiped
            if (index == totalCards - 1) {
              setState(() {
                totalCards += 10;
              });
            }
          },
          cardBuilder: (context, index) {
            final isFirst = index == 0;
            final colorByIndex =
                index == 1 ? const Color(0xFFDA92FC) : const Color(0xFFDC95FB);
            return Stack(
              children: [
                Positioned(
                  bottom: 110.h,
                  right: 0.r,
                  left: 0.r,
                  child: TinderCard(
                    isFirst: isFirst,
                    colour: isFirst ? null : colorByIndex,
                  ),
                ),
                if (isFirst)
                  Positioned(
                    bottom: 130.h,
                    right: 20.r,
                    child: Image.asset(
                      MediaRes.microscope,
                      height: 180.h,
                      width: 149.w,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

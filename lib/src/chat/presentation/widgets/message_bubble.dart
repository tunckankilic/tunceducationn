import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/core/utils/constants.dart';
import 'package:tunceducationn/src/auth/domain/entities/user.dart';
import 'package:tunceducationn/src/chat/domain/entities/message.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(this.message, {required this.showSenderInfo, super.key});

  final Message message;
  final bool showSenderInfo;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  LocalUser? user;
  late bool isCurrentUser;

  @override
  void initState() {
    if (widget.message.senderId == context.currentUser!.uid) {
      user = context.currentUser;
      isCurrentUser = true;
    } else {
      isCurrentUser = false;
      context.read<ChatCubit>().getUser(widget.message.senderId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (_, state) {
        if (state is UserFound && user == null) {
          setState(() {
            user = state.user;
          });
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width - 45.w),
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (widget.showSenderInfo && !isCurrentUser)
              Row(
                children: [
                  CircleAvatar(
                    radius: 16.r,
                    backgroundImage: NetworkImage(
                      user == null || (user!.profilePic == null)
                          ? kDefaultAvatar
                          : user!.profilePic!,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    user == null ? 'Unknown User' : user!.fullName,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            Container(
              margin: EdgeInsets.only(top: 4.h, left: isCurrentUser ? 0 : 20.w),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: isCurrentUser
                    ? Colours.currentUserChatBubbleColour
                    : Colours.otherUserChatBubbleColour,
              ),
              child: Text(
                widget.message.message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

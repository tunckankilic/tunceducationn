import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/src/chat/data/models/message_model.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({required this.groupId, super.key});

  final String groupId;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: 'Message',
          hintStyle: TextStyle(
            color: const Color(0xFF9FA5BB),
            fontSize: 14.sp,
          ),
          filled: true,
          fillColor: Colours.chatFieldColour,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 22.w,
            vertical: 8.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.r),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Transform.scale(
            scale: 0.75,
            child: IconButton.filled(
              padding: EdgeInsets.zero,
              icon: Icon(IconlyLight.send, color: Colors.white, size: 24.sp),
              onPressed: () {
                final message = controller.text.trim();
                if (message.isEmpty) return;
                controller.clear();
                focusNode.unfocus();
                context.read<ChatCubit>().sendMessage(
                      MessageModel.empty().copyWith(
                        message: message,
                        senderId: context.currentUser!.uid,
                        groupId: widget.groupId,
                      ),
                    );
              },
            ),
          ),
        ),
      ),
    );
  }
}

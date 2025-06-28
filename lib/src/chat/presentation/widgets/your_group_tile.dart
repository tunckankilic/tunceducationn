import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/common/widgets/time_text.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/chat/domain/entities/group.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:tunceducationn/src/chat/presentation/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YourGroupTile extends StatelessWidget {
  const YourGroupTile(this.group, {super.key});

  final Group group;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(group.name, style: TextStyle(fontSize: 16.sp)),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(360.r),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 24.r,
          child: Image.network(group.groupImageUrl!),
        ),
      ),
      subtitle: group.lastMessage != null
          ? RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: '~ ${group.lastMessageSenderName}: ',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.sp,
                ),
                children: [
                  TextSpan(
                    text: group.lastMessage,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : null,
      trailing: group.lastMessage != null
          ? TimeText(
              group.lastMessageTimestamp!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12.sp),
            )
          : null,
      onTap: () {
        context.push(
          BlocProvider(
            create: (_) => s1<ChatCubit>(),
            child: ChatView(group: group),
          ),
        );
      },
    );
  }
}

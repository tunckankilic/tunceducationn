import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/not_found_text.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/chat/domain/entities/group.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:tunceducationn/src/chat/presentation/widgets/other_group_tile.dart';
import 'package:tunceducationn/src/chat/presentation/widgets/your_group_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsView extends StatefulWidget {
  const GroupsView({super.key});

  @override
  State<GroupsView> createState() => _GroupsViewState();
}

class _GroupsViewState extends State<GroupsView> {
  List<Group> yourGroups = [];
  List<Group> otherGroups = [];

  bool showingDialog = false;

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getGroups();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Chat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, state) {
          if (showingDialog) {
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is ChatError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is JoiningGroup) {
            showingDialog = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is JoinedGroup) {
            CoreUtils.showSnackBar(context, 'Joined group successfully');
          } else if (state is GroupsLoaded) {
            final currentUser = context.currentUser;
            if (currentUser != null) {
              setState(() {
                yourGroups = state.groups
                    .where((group) => group.members.contains(currentUser.uid))
                    .toList();
                otherGroups = state.groups
                    .where((group) => !group.members.contains(currentUser.uid))
                    .toList();
              });
            }
          }
        },
        builder: (context, state) {
          if (state is LoadingGroups) {
            return const LoadingView();
          } else if (state is GroupsLoaded && state.groups.isEmpty) {
            return NotFoundText(
              text:
                  'No groups found\nPlease contact admin or if you are admin, '
                  'add courses',
              textAlign: TextAlign.center,
              fontSize: 16.sp,
            );
          } else if ((state is GroupsLoaded) ||
              (yourGroups.isNotEmpty) ||
              (otherGroups.isNotEmpty)) {
            return ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                if (yourGroups.isNotEmpty) ...[
                  Text(
                    'Your Groups',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 1.h),
                  ...yourGroups.map(YourGroupTile.new),
                ],
                if (otherGroups.isNotEmpty) ...[
                  Text(
                    'Groups',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                  ),
                  Divider(color: Colors.grey.shade300, height: 1.h),
                  ...otherGroups.map(OtherGroupTile.new),
                ],
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

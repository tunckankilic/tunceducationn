import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/src/home/presentation/widgets/notification_bell.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'My Classes',
        style: TextStyle(color: Colors.white),
      ),
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
        NotificationBell(),
        Consumer<UserProvider>(
          builder: (_, provider, __) {
            return Padding(
              padding: EdgeInsets.only(right: 16.r),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: provider.user!.profilePic != null
                    ? NetworkImage(provider.user!.profilePic!)
                    : AssetImage(MediaRes.user) as ImageProvider,
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

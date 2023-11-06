import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) {
        final user = value.user;
        final image =
            user?.profilePic == null || value.user!.profilePic!.isEmpty
                ? null
                : user!.profilePic;
        return Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.user) as ImageProvider,
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? "No User",
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colours.neutralTextColour,
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 16,
            ),
          ],
        );
      },
    );
  }
}

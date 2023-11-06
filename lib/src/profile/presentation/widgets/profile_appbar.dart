import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/res/res.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:tunceducationn/src/auth/presentation/views/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tunceducationn/src/profile/presentation/view/edit_profile_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSize {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: const Text(
        "Account",
        style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 24, color: Colors.white),
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_horiz),
          surfaceTintColor: Colors.white,
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: const PopUpItem(
                icon: Icons.edit_outlined,
                title: "Edit Profile",
              ),
              onTap: () => context.push(
                BlocProvider(
                  create: (_) => s1<AuthBloc>(),
                  child: const EditProfileView(),
                ),
              ),
            ),
            PopupMenuItem<void>(
              child: const PopUpItem(
                icon: Icons.notifications,
                title: "Notification",
              ),
              onTap: () => context.push(
                const Placeholder(),
              ),
            ),
            PopupMenuItem<void>(
              child: const PopUpItem(
                icon: Icons.info,
                title: "Help",
              ),
              onTap: () => context.push(
                const Placeholder(),
              ),
            ),
            PopupMenuItem<void>(
              child: const PopUpItem(
                icon: Icons.info,
                title: "Privacy",
              ),
              onTap: () => _launchURL(),
            ),
            PopupMenuItem<void>(
              padding: EdgeInsets.zero,
              height: 1,
              child: Divider(
                height: 1,
                color: Colors.red[900],
              ),
              onTap: () {},
            ),
            PopupMenuItem<void>(
              child: const PopUpItem(
                icon: Icons.logout,
                title: "Log Out",
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.pushNamedAndRemoveUntil(
                        context,
                        SignInScreen.routeName,
                        (route) => false,
                      ),
                    );
              },
            ),
          ],
          offset: const Offset(0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        )
      ],
    );
  }

  _launchURL() async {
    const url =
        'http://tunckankilic.site/tunceducationn-app-custom-teacher-online-app-privacy/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'URL açılamıyor: $url';
    }
  }

  @override
  Widget get child => const SizedBox();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PopUpItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const PopUpItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        Icon(
          icon,
          color: Colours.neutralTextColour,
        ),
      ],
    );
  }
}

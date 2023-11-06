import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tunceducationn/core/common/app/providers/tab_navigation.dart';
import 'package:tunceducationn/core/common/views/persistent_view.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:tunceducationn/src/chat/presentation/cubit/chat_cubit.dart';
import 'package:tunceducationn/src/chat/presentation/views/groups_view.dart';
import 'package:tunceducationn/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:tunceducationn/src/course/presentation/cubit/course_cubit.dart';
import 'package:tunceducationn/src/home/presentation/views/home_view.dart';
import 'package:tunceducationn/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:tunceducationn/src/profile/presentation/view/profile_view.dart';
import 'package:tunceducationn/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'package:tunceducationn/src/quick_access/presentation/views/quick_access_view.dart';

class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => s1<CourseCubit>()),
              BlocProvider(create: (_) => s1<VideoCubit>()),
              BlocProvider(create: (_) => s1<NotificationCubit>()),
            ],
            child: const HomeView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (context) => s1<CourseCubit>(),
            child: ChangeNotifierProvider(
              create: (_) => QuickAccessTabController(),
              child: const QuickAccessView(),
            ),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(
        TabItem(
          child: BlocProvider(
            create: (_) => s1<ChatCubit>(),
            child: const GroupsView(),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(
          child: BlocProvider(
        create: (context) => s1<AuthBloc>(),
        child: const ProfileView(),
      ))),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 3;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}

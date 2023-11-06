import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunceducationn/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:tunceducationn/core/common/app/providers/tab_navigation.dart';
import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/src/auth/domain/entities/user.dart';
import 'package:tunceducationn/src/course/domain/entities/course.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;
  double get width => size.width;
  double get height => size.height;
  UserProvider get userProvider => read<UserProvider>();
  LocalUser? get currentUser => userProvider.user;
  TabNavigator get tabNavigator => read<TabNavigator>();
  Course? get courseOfTheDay => read<CourseOfTheDayNotifier>().courseOfTheDay;

  void pop() => tabNavigator.pop();
  void push(Widget page) => tabNavigator.push(TabItem(child: page));
}

part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = s1<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => s1<OnBoardingCubit>(),
              child: const OnBoardingScreen(),
            );
          } else if (s1<FirebaseAuth>().currentUser != null) {
            final user = s1<FirebaseAuth>().currentUser!;
            final localUser = LocalUserModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(localUser);
            return const Dashboard();
          }
          return BlocProvider(
            create: (_) => s1<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => s1<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => s1<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case Dashboard.routeName:
      return _pageBuilder(
        (_) => const Dashboard(),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    case CourseDetailsScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailsScreen(settings.arguments! as Course),
        settings: settings,
      );
    case AddVideoView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => s1<CourseCubit>()),
            BlocProvider(create: (_) => s1<VideoCubit>()),
            BlocProvider(create: (_) => s1<NotificationCubit>()),
          ],
          child: const AddVideoView(),
        ),
        settings: settings,
      );
    case AddMaterialView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => s1<CourseCubit>()),
            BlocProvider(create: (_) => s1<MaterialCubit>()),
            BlocProvider(create: (_) => s1<NotificationCubit>()),
          ],
          child: const AddMaterialView(),
        ),
        settings: settings,
      );
    case AddExamView.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => s1<CourseCubit>()),
            BlocProvider(create: (_) => s1<ExamCubit>()),
            BlocProvider(create: (_) => s1<NotificationCubit>()),
          ],
          child: const AddExamView(),
        ),
        settings: settings,
      );
    case VideoPlayerView.routeName:
      return _pageBuilder(
        (_) => VideoPlayerView(videoURL: settings.arguments! as String),
        settings: settings,
      );
    case CourseVideosView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => s1<VideoCubit>(),
          child: CourseVideosView(settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseMaterialsView.routeName:
      return _pageBuilder(
          (_) => BlocProvider(
                create: (_) => s1<MaterialCubit>(),
                child: CourseMaterialsView(settings.arguments! as Course),
              ),
          settings: settings);
    case CourseExamsView.routeName:
      return _pageBuilder(
          (p0) => BlocProvider(
                create: (_) => s1<ExamCubit>(),
                child: CourseExamsView(settings.arguments! as Course),
              ),
          settings: settings);
    case ExamDetailsView.routeName:
      return _pageBuilder((p0) => ExamDetailsView(settings.arguments! as Exam),
          settings: settings);
    case ExamView.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => s1<ExamCubit>(),
          child: ChangeNotifierProvider(
            create: (context) => ExamController(
              exam: settings.arguments! as Exam,
            ),
            child: const ExamView(),
          ),
        ),
        settings: settings,
      );
    case ExamHistoryDetailsScreen.routeName:
      return _pageBuilder(
        (p0) => ExamHistoryDetailsScreen(settings.arguments! as UserExam),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}

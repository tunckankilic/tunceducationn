import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunceducationn/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:tunceducationn/core/common/app/providers/notifications_notifier.dart';
import 'package:tunceducationn/core/common/app/providers/user_provider.dart';
import 'package:tunceducationn/core/core.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/course/features/exams/domain/entities/exam.dart';
import 'package:tunceducationn/src/course/features/exams/presentation/app/providers/exam_controller.dart';
import 'package:tunceducationn/src/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:tunceducationn/src/quick_access/presentation/providers/quick_access_tab_controller.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardController(),
        ),
        ChangeNotifierProvider(
          create: (_) => CourseOfTheDayNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationsNotifier(
            s1<SharedPreferences>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ExamController(
            exam: s1<Exam>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => QuickAccessTabController(),
        ),
      ],
      child: MaterialApp(
        title: 'TuncEducation',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: Fonts.poppins,
          appBarTheme: const AppBarTheme(
            color: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color.fromARGB(255, 182, 0, 0)),
        ),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

part of 'injection_container.dart';

final s1 = GetIt.instance;

Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initMaterial();
  await _initExam();
  await _initNotifications();
  await _initChat();
}

Future<void> _initChat() async {
  s1
    ..registerFactory(
      () => ChatCubit(
        getGroups: s1(),
        getMessages: s1(),
        getUserById: s1(),
        joinGroup: s1(),
        leaveGroup: s1(),
        sendMessage: s1(),
      ),
    )
    ..registerLazySingleton(() => GetGroups(s1()))
    ..registerLazySingleton(() => GetMessages(s1()))
    ..registerLazySingleton(() => GetUserById(s1()))
    ..registerLazySingleton(() => JoinGroup(s1()))
    ..registerLazySingleton(() => LeaveGroup(s1()))
    ..registerLazySingleton(() => SendMessage(s1()))
    ..registerLazySingleton<ChatRepo>(() => ChatRepoImpl(s1()))
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(firestore: s1(), auth: s1()),
    );
}

Future<void> _initNotifications() async {
  s1
    ..registerFactory(
      () => NotificationCubit(
        clear: s1(),
        clearAll: s1(),
        getNotifications: s1(),
        markAsRead: s1(),
        sendNotification: s1(),
      ),
    )
    ..registerLazySingleton(() => Clear(s1()))
    ..registerLazySingleton(() => ClearAll(s1()))
    ..registerLazySingleton(() => GetNotifications(s1()))
    ..registerLazySingleton(() => MarkAsRead(s1()))
    ..registerLazySingleton(() => SendNotification(s1()))
    ..registerLazySingleton<NotificationRepo>(() => NotificationRepoImpl(s1()))
    ..registerLazySingleton<NotificationRemoteDataSrc>(
      () => NotificationRemoteDataSrcImpl(firestore: s1(), auth: s1()),
    );
}

Future<void> _initExam() async {
  s1
    ..registerFactory(
      () => ExamCubit(
        getExamQuestions: s1(),
        getExams: s1(),
        submitExam: s1(),
        updateExam: s1(),
        uploadExam: s1(),
        getUserCourseExams: s1(),
        getUserExams: s1(),
      ),
    )
    ..registerLazySingleton(() => GetExamQuestions(s1()))
    ..registerLazySingleton(() => GetExams(s1()))
    ..registerLazySingleton(() => SubmitExam(s1()))
    ..registerLazySingleton(() => UpdateExam(s1()))
    ..registerLazySingleton(() => UploadExam(s1()))
    ..registerLazySingleton(() => GetUserCourseExams(s1()))
    ..registerLazySingleton(() => GetUserExams(s1()))
    ..registerLazySingleton<ExamRepo>(() => ExamRepoImpl(s1()))
    ..registerLazySingleton<ExamRemoteDataSrc>(
      () => ExamRemoteDataSrcImpl(auth: s1(), firestore: s1()),
    );
}

Future<void> _initMaterial() async {
  s1
    ..registerFactory(
      () => MaterialCubit(
        addMaterial: s1(),
        getMaterials: s1(),
      ),
    )
    ..registerLazySingleton(() => AddMaterial(s1()))
    ..registerLazySingleton(() => GetMaterials(s1()))
    ..registerLazySingleton<MaterialRepo>(() => MaterialRepoImpl(s1()))
    ..registerLazySingleton<MaterialRemoteDataSrc>(
      () => MaterialRemoteDataSrcImpl(
        firestore: s1(),
        auth: s1(),
        storage: s1(),
      ),
    )
    ..registerFactory(
      () => ResourceController(
        storage: s1(),
        prefs: s1(),
      ),
    );
}

Future<void> _initVideo() async {
  s1
    ..registerFactory(() => VideoCubit(addVideo: s1(), getVideos: s1()))
    ..registerLazySingleton(() => AddVideo(s1()))
    ..registerLazySingleton(() => GetVideos(s1()))
    ..registerLazySingleton<VideoRepo>(() => VideoRepoImpl(s1()))
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: s1(), auth: s1(), storage: s1()),
    );
}

Future<void> _initCourse() async {
  s1
    ..registerFactory(
      () => CourseCubit(
        addCourse: s1(),
        getCourses: s1(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(s1()))
    ..registerLazySingleton(() => GetCourses(s1()))
    ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(s1()))
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firestore: s1(),
        storage: s1(),
        auth: s1(),
      ),
    );
}

Future<void> _initAuth() async {
  s1
    ..registerFactory(
      () => AuthBloc(
        signIn: s1(),
        signUp: s1(),
        forgotPassword: s1(),
        updateUser: s1(),
      ),
    )
    ..registerLazySingleton(() => SignIn(s1()))
    ..registerLazySingleton(() => SignUp(s1()))
    ..registerLazySingleton(() => ForgotPassword(s1()))
    ..registerLazySingleton(() => UpdateUser(s1()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(s1()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: s1(),
        cloudStoreClient: s1(),
        dbClient: s1(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  // Feature --> OnBoarding
  // Business Logic
  s1
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: s1(),
        checkIfUserIsFirstTimer: s1(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(s1()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(s1()))
    ..registerLazySingleton<OnBoardingRepo>(
        () => OnBoardingRepoImplementation(s1()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(s1()),
    )
    ..registerLazySingleton(() => prefs);
}

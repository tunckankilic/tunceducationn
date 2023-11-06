import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tunceducationn/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late MockOnBoardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    // MockOnBoardingRepo ve CheckIfUserIsFirstTimer sınıflarını oluşturun.
    repo = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
    'should get a response from the [MockOnBoardingRepo]',
    () async {
      // arrange: MockOnBoardingRepo'nun checkIfUserIsFirstTimer() metodunu çağırıldığında belirli bir sonuç döndüreceğini ayarlayın.
      when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );

      // act: usecase işlemini çağırın.
      final result = await usecase();

      // assert: Sonucun beklenen Right(true) ile aynı olduğunu doğrulayın.
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => repo.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}

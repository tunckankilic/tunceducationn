import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/src/on_boarding/data/datasources/datasources.dart';
import 'package:tunceducationn/src/on_boarding/data/repositories/on_boarding_repo_implementation.dart';
import 'package:tunceducationn/src/on_boarding/domain/domain.dart';

class MockOnboardingLocalDataSrc extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepoImplementation repoImplementation;

  setUp(() {
    // Mock OnBoardingLocalDataSource ve OnBoardingRepoImplementation sınıflarını oluşturun.
    localDataSource = MockOnboardingLocalDataSrc();
    repoImplementation = OnBoardingRepoImplementation(localDataSource);
  });

  test("should be a subclass of [OnBoardingRepo]", () {
    // repoImplementation'ın OnBoardingRepo türünde olduğunu doğrulayın.
    expect(repoImplementation, isA<OnBoardingRepo>());
  });

  group('cacheFirstTimer', () {
    test(
      'should complete successfully when call to local source is successful',
      () async {
        // localDataSource.cacheFirstTimer() başarılı bir şekilde tamamlandığında Future.value() ile yanıt verir.
        when(() => localDataSource.cacheFirstTimer()).thenAnswer(
          (_) async => Future.value(),
        );

        // cacheFirstTimer işlevini çağırın ve sonucun beklenen Right ile aynı olduğunu doğrulayın.
        final result = await repoImplementation.cacheFirstTimer();

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
    test(
      'should return [CacheFailure] when call to local source is unsuccessful',
      () async {
        // localDataSource.cacheFirstTimer() hata fırlattığında bir CacheExceptions bekleyin.
        when(() => localDataSource.cacheFirstTimer()).thenThrow(
          const CacheExceptions(
              message: 'Insufficient storage', statusCode: 500),
        );

        // cacheFirstTimer işlevini çağırın ve sonucun beklenen CacheFailure ile aynı olduğunu doğrulayın.
        final result = await repoImplementation.cacheFirstTimer();

        expect(
          result,
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient storage', statusCode: 500),
          ),
        );
        verify(() => localDataSource.cacheFirstTimer());
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
  group('checkIfUserIsFirstTimer', () {
    test(
      'should return true when user is first timer',
      () async {
        // localDataSource.checkIfUserIsFirstTimer() true döndüğünde Future.value(true) ile yanıt verir.
        when(() => localDataSource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(true));

        // checkIfUserIsFirstTimer işlevini çağırın ve sonucun beklenen Right ile aynı olduğunu doğrulayın.
        final result = await repoImplementation.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(true)));

        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return false when user is not first timer',
      () async {
        // localDataSource.checkIfUserIsFirstTimer() false döndüğünde Future.value(false) ile yanıt verir.
        when(() => localDataSource.checkIfUserIsFirstTimer())
            .thenAnswer((_) async => Future.value(false));

        // checkIfUserIsFirstTimer işlevini çağırın ve sonucun beklenen Right ile aynı olduğunu doğrulayın.
        final result = await repoImplementation.checkIfUserIsFirstTimer();

        expect(result, equals(const Right<dynamic, bool>(false)));

        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return a CacheFailure when call to local data source '
      'is unsuccessful',
      () async {
        // localDataSource.checkIfUserIsFirstTimer() hata fırlattığında bir CacheExceptions bekleyin.
        when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
          const CacheExceptions(
            message: 'Insufficient permissions',
            statusCode: 403,
          ),
        );

        // checkIfUserIsFirstTimer işlevini çağırın ve sonucun beklenen CacheFailure ile aynı olduğunu doğrulayın.
        final result = await repoImplementation.checkIfUserIsFirstTimer();

        expect(
          result,
          equals(
            Left<CacheFailure, bool>(
              CacheFailure(
                message: 'Insufficient permissions',
                statusCode: 403,
              ),
            ),
          ),
        );

        verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);

        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}

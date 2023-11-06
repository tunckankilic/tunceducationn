import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/src/on_boarding/domain/usecases/usecases.dart';
import 'package:tunceducationn/src/on_boarding/presentation/cubit/on_boarding/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  setUp(() {
    // MockCacheFirstTimer ve MockCheckIfUserIsFirstTimer sınıflarını oluşturun.
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    // OnBoardingCubit sınıfını oluşturun ve mock sınıfları enjekte edin.
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  final tFailure = CacheFailure(
    message: 'Insufficient storage permission',
    statusCode: 4032,
  );

  test('initial state should be [OnBoardingInitial]', () {
    // Başlangıç durumunun [OnBoardingInitial] ile eşleştiğini doğrulayın.
    expect(cubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CachingFirstTimer, UserCached] when successful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [
        CachingFirstTimer(),
        UserCached(),
      ],
      verify: (_) {
        // cacheFirstTimer'ın doğru bir şekilde çağrıldığını ve diğer etkileşimlerin olmadığını doğrulayın.
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit '
      '[CachingFirstTimer, OnBoardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () {
        // Hata durumunda beklenen durumları oluşturun ve döndürün.
        return [
          const CachingFirstTimer(),
          OnBoardingError(tFailure.errorMessage),
        ];
      },
      verify: (_) {
        // cacheFirstTimer'ın doğru bir şekilde çağrıldığını ve diğer etkileşimlerin olmadığını doğrulayın.
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => const Right(false),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () {
        // Başarılı durumlar için beklenen durumları oluşturun ve döndürün.
        return [
          const CheckingIfUserIsFirstTimer(),
          const OnBoardingStatus(isFirstTimer: false),
        ];
      },
      verify: (_) {
        // checkIfUserIsFirstTimer'ın doğru bir şekilde çağrıldığını ve diğer etkileşimlerin olmadığını doğrulayın.
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );

    blocTest<OnBoardingCubit, OnBoardingState>(
      'should emit [CheckingIfUserIsFirstTImer, OnBoardingState(true)] when '
      'unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () {
        // Hata durumunda beklenen durumları oluşturun ve döndürün.
        return const [
          CheckingIfUserIsFirstTimer(),
          OnBoardingStatus(isFirstTimer: true),
        ];
      },
      verify: (_) {
        // checkIfUserIsFirstTimer'ın doğru bir şekilde çağrıldığını ve diğer etkileşimlerin olmadığını doğrulayın.
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );
  });
}

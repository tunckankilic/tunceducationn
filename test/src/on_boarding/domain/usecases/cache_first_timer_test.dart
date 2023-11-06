import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/src/on_boarding/domain/repositories/on_boarding_repo.dart';
import 'package:tunceducationn/src/on_boarding/domain/usecases/usecases.dart';

import 'on_boarding_repo.mock.dart';

void main() {
  late OnBoardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    // OnBoardingRepo ve CacheFirstTimer sınıflarını oluşturun.
    repo = MockOnBoardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
    'should call the [OnBoardingRepo.cacheFirstTimer] '
    'and return the right data',
    () async {
      // OnBoardingRepo.cacheFirstTimer() çağrıldığında hata fırlatır.
      when(() => repo.cacheFirstTimer()).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        ),
      );

      // usecase işlemini çağırın ve sonucun beklenen ServerFailure ile aynı olduğunu doğrulayın.
      final result = await usecase();

      expect(
        result,
        equals(
          Left<Failure, dynamic>(
            ServerFailure(
              message: 'Unknown Error Occurred',
              statusCode: 500,
            ),
          ),
        ),
      );
      verify(() => repo.cacheFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}

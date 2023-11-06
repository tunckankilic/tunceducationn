import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunceducationn/core/errors/errors.dart';
import 'package:tunceducationn/src/on_boarding/data/data.dart';

// A mock class for simulating SharedPreferences.
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSrcImpl(prefs);
  });

  group('cacheFirstTimer', () {
    test(
      'should call [SharedPreferences] to cache the data',
      () async {
        // Simulate a successful call to SharedPreferences to cache the data.
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

        await localDataSource.cacheFirstTimer();

        // Verify that the setBool method was called with the correct parameters.
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error caching the data',
      () async {
        // Simulate an error when calling SharedPreferences to cache the data.
        when(() => prefs.setBool(any(), any())).thenThrow(Exception());

        final methodCall = localDataSource.cacheFirstTimer;

        // Verify that the method call throws a CacheExceptions.
        expect(methodCall, throwsA(isA<CacheExceptions>()));
        verify(() => prefs.setBool(kFirstTimerKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    test(
      'should call [SharedPreferences] to check if user is first timer and '
      'return the right response from storage when data exists',
      () async {
        // Simulate a response from SharedPreferences when data exists.
        when(() => prefs.getBool(any())).thenReturn(false);

        final result = await localDataSource.checkIfUserIsFirstTimer();

        // Verify that the result matches the expected value.
        expect(result, false);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should return true if there is no data in storage',
      () async {
        // Simulate a null response from SharedPreferences when no data exists.
        when(() => prefs.getBool(any())).thenReturn(null);

        final result = await localDataSource.checkIfUserIsFirstTimer();

        // Verify that the result matches the expected value.
        expect(result, true);

        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error '
      'retrieving the data',
      () async {
        // Simulate an error when calling SharedPreferences to retrieve the data.
        when(() => prefs.getBool(any())).thenThrow(Exception());
        final call = localDataSource.checkIfUserIsFirstTimer;

        // Verify that the method call throws a CacheExceptions.
        expect(call, throwsA(isA<CacheExceptions>()));
        verify(() => prefs.getBool(kFirstTimerKey)).called(1);

        verifyNoMoreInteractions(prefs);
      },
    );
  });
}

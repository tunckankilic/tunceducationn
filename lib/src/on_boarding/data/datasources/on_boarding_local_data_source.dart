import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunceducationn/core/errors/errors.dart';

// An abstract class representing a local data source for the OnBoarding feature.
abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  // Caches the information about whether the user is a first-time user.
  Future<void> cacheFirstTimer();

  // Checks if the user is a first-time user.
  Future<bool> checkIfUserIsFirstTimer();
}

// The key used to store first-time user information in SharedPreferences.
const kFirstTimerKey = 'first_timer';

// An implementation of the OnBoardingLocalDataSource using SharedPreferences.
class OnBoardingLocalDataSrcImpl extends OnBoardingLocalDataSource {
  const OnBoardingLocalDataSrcImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      // Cache the first-timer information in SharedPreferences.
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      // Handle any caching errors and throw a CacheExceptions.
      throw CacheExceptions(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      // Check if the user is a first-time user based on the stored information.
      return _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      // Handle any retrieval errors and throw a CacheExceptions.
      throw CacheExceptions(message: e.toString());
    }
  }
}

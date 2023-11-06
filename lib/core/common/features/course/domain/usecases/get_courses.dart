import 'package:tunceducationn/core/common/features/course/domain/entities/course.dart';
import 'package:tunceducationn/core/common/features/course/domain/repos/course_repo.dart';
import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/utils.dart';

class GetCourses extends FutureUsecaseWithoutParams<List<Course>> {
  const GetCourses(this._repo);

  final CourseRepo _repo;

  @override
  ResultFuture<List<Course>> call() async => _repo.getCourses();
}

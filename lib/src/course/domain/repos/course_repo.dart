import 'package:tunceducationn/core/utils/utils.dart';
import 'package:tunceducationn/src/course/domain/entities/course.dart';

abstract class CourseRepo {
  const CourseRepo();

  ResultFuture<List<Course>> getCourses();

  ResultFuture<void> addCourse(Course course);
}

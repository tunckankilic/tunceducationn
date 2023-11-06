import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/course/features/exams/domain/entities/exam.dart';
import 'package:tunceducationn/src/course/features/exams/domain/repos/exam_repo.dart';

class UploadExam extends FutureUsecaseWithParams<void, Exam> {
  const UploadExam(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<void> call(Exam params) => _repo.uploadExam(params);
}

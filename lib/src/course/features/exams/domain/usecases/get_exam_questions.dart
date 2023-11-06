import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/course/features/exams/domain/entities/exam.dart';
import 'package:tunceducationn/src/course/features/exams/domain/entities/exam_question.dart';
import 'package:tunceducationn/src/course/features/exams/domain/repos/exam_repo.dart';

class GetExamQuestions
    extends FutureUsecaseWithParams<List<ExamQuestion>, Exam> {
  const GetExamQuestions(this._repo);

  final ExamRepo _repo;

  @override
  ResultFuture<List<ExamQuestion>> call(Exam params) =>
      _repo.getExamQuestions(params);
}

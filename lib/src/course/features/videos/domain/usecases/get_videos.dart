import 'package:tunceducationn/core/usecases/usecases.dart';
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/course/features/videos/domain/entities/video.dart';
import 'package:tunceducationn/src/course/features/videos/domain/repos/video_repo.dart';

class GetVideos extends FutureUsecaseWithParams<List<Video>, String> {
  const GetVideos(this._repo);

  final VideoRepo _repo;

  @override
  ResultFuture<List<Video>> call(String params) => _repo.getVideos(params);
}

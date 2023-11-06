import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/course/features/videos/domain/entities/video.dart';

abstract class VideoRepo {
  const VideoRepo();

  // We could make this a stream, but for the sakes of tutorials,
  // we'll keep it simple
  ResultFuture<List<Video>> getVideos(String courseId);

  ResultFuture<void> addVideo(Video video);
}

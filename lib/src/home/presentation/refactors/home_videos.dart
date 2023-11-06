import 'package:tunceducationn/core/common/views/loading_view.dart';
import 'package:tunceducationn/core/common/widgets/not_found_text.dart';
import 'package:tunceducationn/core/common/widgets/video_tile.dart';
import 'package:tunceducationn/core/extensions/context_extension.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/core/utils/core_utils.dart';
import 'package:tunceducationn/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:tunceducationn/src/home/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({super.key});

  @override
  State<HomeVideos> createState() => _HomeVideosState();
}

class _HomeVideosState extends State<HomeVideos> {
  void getVideos() {
    context.read<VideoCubit>().getVideos(context.courseOfTheDay!.id);
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCubit, VideoState>(
      listener: (context, state) {
        if (state is VideoError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingVideos) {
          return const LoadingView();
        } else if ((state is VideosLoaded && state.videos.isEmpty) ||
            state is VideoError) {
          return NotFoundText(
            'No videos found for ${context.courseOfTheDay!.title}',
          );
        } else if (state is VideosLoaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                sectionTitle: '${context.courseOfTheDay!.title} Videos',
                seeAll: state.videos.length > 4,
                onSeeAll: () => context.push(
                  BlocProvider(
                    create: (_) => s1<VideoCubit>(),
                    // child: CourseVideosView(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              for (final video in state.videos.take(5))
                VideoTile(video, tappable: true),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

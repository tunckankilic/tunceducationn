// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:tunceducationn/core/core.dart';

// A class to represent the content of onboarding pages.
class PageContent extends Equatable {
  final String image; // The image associated with the content.
  final String title; // The title of the content.
  final String description; // The description of the content.

  const PageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  // Factory constructors to create specific PageContent instances for each page.
  const PageContent.first()
      : this(
          image: MediaRes.casualReading,
          title: "Brand New Curriculum",
          description:
              "This is the first online education platform\ndesigned by the world's top professors",
        );

  const PageContent.second()
      : this(
          image: MediaRes.casualLife,
          title: "Brand a fun atmosphere",
          description:
              "This is the first online education platform\ndesigned by the world's top professors",
        );

  const PageContent.third()
      : this(
            image: MediaRes.casualMeditationScience,
            description:
                "This is the first online education platform\ndesigned by the world's top professors",
            title: "Easy to join the lesson");

  @override
  List<Object> get props => [image, title, description];
}

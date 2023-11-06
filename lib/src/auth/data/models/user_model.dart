// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tunceducationn/core/utils/typedefs.dart';
import 'package:tunceducationn/src/auth/domain/entities/user.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.profilePic,
    super.bio,
    super.enrolledCourseIds = const [],
    super.following = const [],
    super.groupId = const [],
    super.followers,
  });

  const LocalUserModel.empty()
      : this(uid: "", points: 0, email: "", fullName: "");

  LocalUserModel.fromMap(DataMap map)
      : super(
          uid: map["uid"] as String,
          email: map["email"] as String,
          fullName: map["fullName"] as String, // fullName String olmalı
          points: (map["points"] as num?)?.toInt() ??
              0, // points nullable ve hata durumu ele alınmış
          profilePic: map["profilePic"] as String?,
          bio: map["bio"] as String?,
          groupId: (map["groupId"] as List<dynamic>?)?.cast<String>() ??
              [], // nullable ve hata durumu ele alınmış
          enrolledCourseIds:
              (map["enrolledCourseIds"] as List<dynamic>?)?.cast<String>() ??
                  [], // nullable ve hata durumu ele alınmış
          followers: (map["followers"] as List<dynamic>?)?.cast<String>() ??
              [], // nullable ve hata durumu ele alınmış
          following: (map["following"] as List<dynamic>?)?.cast<String>() ??
              [], // nullable ve hata durumu ele alınmış
        );
  @override
  DataMap toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'groupIds': groupId, // 'groupIds' olarak güncellendi
      'followers': followers,
    };
  }

  @override
  LocalUser copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullName,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? groupId,
    List<String>? followers,
  }) {
    return LocalUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      groupId: groupId ?? this.groupId,
      followers: followers ?? this.followers,
    );
  }
}

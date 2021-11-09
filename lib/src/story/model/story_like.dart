import 'package:json_annotation/json_annotation.dart';
import 'package:kakao_flutter_sdk/src/story/model/story_actor.dart';

part 'story_like.g.dart';

/// 카카오스토리의 좋아요 등 느낌(감정표현)에 대한 정보를 담고 있는 클래스
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class StoryLike {
  @JsonKey(unknownEnumValue: Emoticon.UNKNOWN)
  final Emoticon emoticon;
  final StoryActor actor;

  /// @nodoc
  StoryLike(this.emoticon, this.actor);

  /// @nodoc
  factory StoryLike.fromJson(Map<String, dynamic> json) =>
      _$StoryLikeFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$StoryLikeToJson(this);
}

enum Emoticon { LIKE, COOL, HAPPY, SAD, CHEER_UP, UNKNOWN }

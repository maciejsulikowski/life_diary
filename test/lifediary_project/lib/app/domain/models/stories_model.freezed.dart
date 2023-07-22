// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stories_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoriesModel _$StoriesModelFromJson(Map<String, dynamic> json) {
  return _StoriesModel.fromJson(json);
}

/// @nodoc
mixin _$StoriesModel {
  @JsonKey(name: 'author_id')
  int get authorID => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  String get picture => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoriesModelCopyWith<StoriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoriesModelCopyWith<$Res> {
  factory $StoriesModelCopyWith(
          StoriesModel value, $Res Function(StoriesModel) then) =
      _$StoriesModelCopyWithImpl<$Res, StoriesModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'author_id') int authorID,
      String bio,
      String picture,
      String source});
}

/// @nodoc
class _$StoriesModelCopyWithImpl<$Res, $Val extends StoriesModel>
    implements $StoriesModelCopyWith<$Res> {
  _$StoriesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorID = null,
    Object? bio = null,
    Object? picture = null,
    Object? source = null,
  }) {
    return _then(_value.copyWith(
      authorID: null == authorID
          ? _value.authorID
          : authorID // ignore: cast_nullable_to_non_nullable
              as int,
      bio: null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      picture: null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoriesModelCopyWith<$Res>
    implements $StoriesModelCopyWith<$Res> {
  factory _$$_StoriesModelCopyWith(
          _$_StoriesModel value, $Res Function(_$_StoriesModel) then) =
      __$$_StoriesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'author_id') int authorID,
      String bio,
      String picture,
      String source});
}

/// @nodoc
class __$$_StoriesModelCopyWithImpl<$Res>
    extends _$StoriesModelCopyWithImpl<$Res, _$_StoriesModel>
    implements _$$_StoriesModelCopyWith<$Res> {
  __$$_StoriesModelCopyWithImpl(
      _$_StoriesModel _value, $Res Function(_$_StoriesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authorID = null,
    Object? bio = null,
    Object? picture = null,
    Object? source = null,
  }) {
    return _then(_$_StoriesModel(
      null == authorID
          ? _value.authorID
          : authorID // ignore: cast_nullable_to_non_nullable
              as int,
      null == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String,
      null == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String,
      null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoriesModel implements _StoriesModel {
  _$_StoriesModel(@JsonKey(name: 'author_id') this.authorID, this.bio,
      this.picture, this.source);

  factory _$_StoriesModel.fromJson(Map<String, dynamic> json) =>
      _$$_StoriesModelFromJson(json);

  @override
  @JsonKey(name: 'author_id')
  final int authorID;
  @override
  final String bio;
  @override
  final String picture;
  @override
  final String source;

  @override
  String toString() {
    return 'StoriesModel(authorID: $authorID, bio: $bio, picture: $picture, source: $source)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoriesModel &&
            (identical(other.authorID, authorID) ||
                other.authorID == authorID) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, authorID, bio, picture, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoriesModelCopyWith<_$_StoriesModel> get copyWith =>
      __$$_StoriesModelCopyWithImpl<_$_StoriesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoriesModelToJson(
      this,
    );
  }
}

abstract class _StoriesModel implements StoriesModel {
  factory _StoriesModel(
      @JsonKey(name: 'author_id') final int authorID,
      final String bio,
      final String picture,
      final String source) = _$_StoriesModel;

  factory _StoriesModel.fromJson(Map<String, dynamic> json) =
      _$_StoriesModel.fromJson;

  @override
  @JsonKey(name: 'author_id')
  int get authorID;
  @override
  String get bio;
  @override
  String get picture;
  @override
  String get source;
  @override
  @JsonKey(ignore: true)
  _$$_StoriesModelCopyWith<_$_StoriesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

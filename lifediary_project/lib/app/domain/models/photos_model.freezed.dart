// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photos_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PhotosModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  DateTime get releaseDate => throw _privateConstructorUsedError;
  String get weight => throw _privateConstructorUsedError;
  String get height => throw _privateConstructorUsedError;
  String get goals => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotosModelCopyWith<PhotosModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotosModelCopyWith<$Res> {
  factory $PhotosModelCopyWith(
          PhotosModel value, $Res Function(PhotosModel) then) =
      _$PhotosModelCopyWithImpl<$Res, PhotosModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String imageURL,
      DateTime releaseDate,
      String weight,
      String height,
      String goals});
}

/// @nodoc
class _$PhotosModelCopyWithImpl<$Res, $Val extends PhotosModel>
    implements $PhotosModelCopyWith<$Res> {
  _$PhotosModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageURL = null,
    Object? releaseDate = null,
    Object? weight = null,
    Object? height = null,
    Object? goals = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PhotosModelCopyWith<$Res>
    implements $PhotosModelCopyWith<$Res> {
  factory _$$_PhotosModelCopyWith(
          _$_PhotosModel value, $Res Function(_$_PhotosModel) then) =
      __$$_PhotosModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String imageURL,
      DateTime releaseDate,
      String weight,
      String height,
      String goals});
}

/// @nodoc
class __$$_PhotosModelCopyWithImpl<$Res>
    extends _$PhotosModelCopyWithImpl<$Res, _$_PhotosModel>
    implements _$$_PhotosModelCopyWith<$Res> {
  __$$_PhotosModelCopyWithImpl(
      _$_PhotosModel _value, $Res Function(_$_PhotosModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageURL = null,
    Object? releaseDate = null,
    Object? weight = null,
    Object? height = null,
    Object? goals = null,
  }) {
    return _then(_$_PhotosModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_PhotosModel extends _PhotosModel {
  _$_PhotosModel(
      {required this.id,
      required this.title,
      required this.imageURL,
      required this.releaseDate,
      this.weight = '',
      this.height = '',
      this.goals = ''})
      : super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageURL;
  @override
  final DateTime releaseDate;
  @override
  @JsonKey()
  final String weight;
  @override
  @JsonKey()
  final String height;
  @override
  @JsonKey()
  final String goals;

  @override
  String toString() {
    return 'PhotosModel(id: $id, title: $title, imageURL: $imageURL, releaseDate: $releaseDate, weight: $weight, height: $height, goals: $goals)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PhotosModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.goals, goals) || other.goals == goals));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, imageURL, releaseDate, weight, height, goals);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PhotosModelCopyWith<_$_PhotosModel> get copyWith =>
      __$$_PhotosModelCopyWithImpl<_$_PhotosModel>(this, _$identity);
}

abstract class _PhotosModel extends PhotosModel {
  factory _PhotosModel(
      {required final String id,
      required final String title,
      required final String imageURL,
      required final DateTime releaseDate,
      final String weight,
      final String height,
      final String goals}) = _$_PhotosModel;
  _PhotosModel._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageURL;
  @override
  DateTime get releaseDate;
  @override
  String get weight;
  @override
  String get height;
  @override
  String get goals;
  @override
  @JsonKey(ignore: true)
  _$$_PhotosModelCopyWith<_$_PhotosModel> get copyWith =>
      throw _privateConstructorUsedError;
}

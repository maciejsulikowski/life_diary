// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TrainingState {
  PhotosModel? get photosModel => throw _privateConstructorUsedError;
  List<PhotosModel> get photos => throw _privateConstructorUsedError;
  bool get loadingErrorOccured => throw _privateConstructorUsedError;
  bool get removingErrorOccured => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TrainingStateCopyWith<TrainingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingStateCopyWith<$Res> {
  factory $TrainingStateCopyWith(
          TrainingState value, $Res Function(TrainingState) then) =
      _$TrainingStateCopyWithImpl<$Res, TrainingState>;
  @useResult
  $Res call(
      {PhotosModel? photosModel,
      List<PhotosModel> photos,
      bool loadingErrorOccured,
      bool removingErrorOccured});

  $PhotosModelCopyWith<$Res>? get photosModel;
}

/// @nodoc
class _$TrainingStateCopyWithImpl<$Res, $Val extends TrainingState>
    implements $TrainingStateCopyWith<$Res> {
  _$TrainingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photosModel = freezed,
    Object? photos = null,
    Object? loadingErrorOccured = null,
    Object? removingErrorOccured = null,
  }) {
    return _then(_value.copyWith(
      photosModel: freezed == photosModel
          ? _value.photosModel
          : photosModel // ignore: cast_nullable_to_non_nullable
              as PhotosModel?,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotosModel>,
      loadingErrorOccured: null == loadingErrorOccured
          ? _value.loadingErrorOccured
          : loadingErrorOccured // ignore: cast_nullable_to_non_nullable
              as bool,
      removingErrorOccured: null == removingErrorOccured
          ? _value.removingErrorOccured
          : removingErrorOccured // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PhotosModelCopyWith<$Res>? get photosModel {
    if (_value.photosModel == null) {
      return null;
    }

    return $PhotosModelCopyWith<$Res>(_value.photosModel!, (value) {
      return _then(_value.copyWith(photosModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_TrainingStateCopyWith<$Res>
    implements $TrainingStateCopyWith<$Res> {
  factory _$$_TrainingStateCopyWith(
          _$_TrainingState value, $Res Function(_$_TrainingState) then) =
      __$$_TrainingStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PhotosModel? photosModel,
      List<PhotosModel> photos,
      bool loadingErrorOccured,
      bool removingErrorOccured});

  @override
  $PhotosModelCopyWith<$Res>? get photosModel;
}

/// @nodoc
class __$$_TrainingStateCopyWithImpl<$Res>
    extends _$TrainingStateCopyWithImpl<$Res, _$_TrainingState>
    implements _$$_TrainingStateCopyWith<$Res> {
  __$$_TrainingStateCopyWithImpl(
      _$_TrainingState _value, $Res Function(_$_TrainingState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photosModel = freezed,
    Object? photos = null,
    Object? loadingErrorOccured = null,
    Object? removingErrorOccured = null,
  }) {
    return _then(_$_TrainingState(
      photosModel: freezed == photosModel
          ? _value.photosModel
          : photosModel // ignore: cast_nullable_to_non_nullable
              as PhotosModel?,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<PhotosModel>,
      loadingErrorOccured: null == loadingErrorOccured
          ? _value.loadingErrorOccured
          : loadingErrorOccured // ignore: cast_nullable_to_non_nullable
              as bool,
      removingErrorOccured: null == removingErrorOccured
          ? _value.removingErrorOccured
          : removingErrorOccured // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_TrainingState implements _TrainingState {
  _$_TrainingState(
      {this.photosModel,
      final List<PhotosModel> photos = const [],
      this.loadingErrorOccured = false,
      this.removingErrorOccured = false})
      : _photos = photos;

  @override
  final PhotosModel? photosModel;
  final List<PhotosModel> _photos;
  @override
  @JsonKey()
  List<PhotosModel> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  @override
  @JsonKey()
  final bool loadingErrorOccured;
  @override
  @JsonKey()
  final bool removingErrorOccured;

  @override
  String toString() {
    return 'TrainingState(photosModel: $photosModel, photos: $photos, loadingErrorOccured: $loadingErrorOccured, removingErrorOccured: $removingErrorOccured)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingState &&
            (identical(other.photosModel, photosModel) ||
                other.photosModel == photosModel) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            (identical(other.loadingErrorOccured, loadingErrorOccured) ||
                other.loadingErrorOccured == loadingErrorOccured) &&
            (identical(other.removingErrorOccured, removingErrorOccured) ||
                other.removingErrorOccured == removingErrorOccured));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      photosModel,
      const DeepCollectionEquality().hash(_photos),
      loadingErrorOccured,
      removingErrorOccured);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingStateCopyWith<_$_TrainingState> get copyWith =>
      __$$_TrainingStateCopyWithImpl<_$_TrainingState>(this, _$identity);
}

abstract class _TrainingState implements TrainingState {
  factory _TrainingState(
      {final PhotosModel? photosModel,
      final List<PhotosModel> photos,
      final bool loadingErrorOccured,
      final bool removingErrorOccured}) = _$_TrainingState;

  @override
  PhotosModel? get photosModel;
  @override
  List<PhotosModel> get photos;
  @override
  bool get loadingErrorOccured;
  @override
  bool get removingErrorOccured;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingStateCopyWith<_$_TrainingState> get copyWith =>
      throw _privateConstructorUsedError;
}

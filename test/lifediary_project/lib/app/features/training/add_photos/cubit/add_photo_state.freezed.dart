// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_photo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddPhotoState {
  bool get saved => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddPhotoStateCopyWith<AddPhotoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddPhotoStateCopyWith<$Res> {
  factory $AddPhotoStateCopyWith(
          AddPhotoState value, $Res Function(AddPhotoState) then) =
      _$AddPhotoStateCopyWithImpl<$Res, AddPhotoState>;
  @useResult
  $Res call({bool saved, String errorMessage});
}

/// @nodoc
class _$AddPhotoStateCopyWithImpl<$Res, $Val extends AddPhotoState>
    implements $AddPhotoStateCopyWith<$Res> {
  _$AddPhotoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saved = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddPhotoStateCopyWith<$Res>
    implements $AddPhotoStateCopyWith<$Res> {
  factory _$$_AddPhotoStateCopyWith(
          _$_AddPhotoState value, $Res Function(_$_AddPhotoState) then) =
      __$$_AddPhotoStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool saved, String errorMessage});
}

/// @nodoc
class __$$_AddPhotoStateCopyWithImpl<$Res>
    extends _$AddPhotoStateCopyWithImpl<$Res, _$_AddPhotoState>
    implements _$$_AddPhotoStateCopyWith<$Res> {
  __$$_AddPhotoStateCopyWithImpl(
      _$_AddPhotoState _value, $Res Function(_$_AddPhotoState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? saved = null,
    Object? errorMessage = null,
  }) {
    return _then(_$_AddPhotoState(
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AddPhotoState implements _AddPhotoState {
  _$_AddPhotoState({this.saved = false, this.errorMessage = ''});

  @override
  @JsonKey()
  final bool saved;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'AddPhotoState(saved: $saved, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddPhotoState &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, saved, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddPhotoStateCopyWith<_$_AddPhotoState> get copyWith =>
      __$$_AddPhotoStateCopyWithImpl<_$_AddPhotoState>(this, _$identity);
}

abstract class _AddPhotoState implements AddPhotoState {
  factory _AddPhotoState({final bool saved, final String errorMessage}) =
      _$_AddPhotoState;

  @override
  bool get saved;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_AddPhotoStateCopyWith<_$_AddPhotoState> get copyWith =>
      throw _privateConstructorUsedError;
}

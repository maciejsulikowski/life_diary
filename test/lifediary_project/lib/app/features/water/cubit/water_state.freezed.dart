// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WaterState {
  WaterModel? get glasses => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WaterStateCopyWith<WaterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaterStateCopyWith<$Res> {
  factory $WaterStateCopyWith(
          WaterState value, $Res Function(WaterState) then) =
      _$WaterStateCopyWithImpl<$Res, WaterState>;
  @useResult
  $Res call({WaterModel? glasses, bool isSaved, Status status});
}

/// @nodoc
class _$WaterStateCopyWithImpl<$Res, $Val extends WaterState>
    implements $WaterStateCopyWith<$Res> {
  _$WaterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? glasses = freezed,
    Object? isSaved = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      glasses: freezed == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as WaterModel?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WaterStateCopyWith<$Res>
    implements $WaterStateCopyWith<$Res> {
  factory _$$_WaterStateCopyWith(
          _$_WaterState value, $Res Function(_$_WaterState) then) =
      __$$_WaterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WaterModel? glasses, bool isSaved, Status status});
}

/// @nodoc
class __$$_WaterStateCopyWithImpl<$Res>
    extends _$WaterStateCopyWithImpl<$Res, _$_WaterState>
    implements _$$_WaterStateCopyWith<$Res> {
  __$$_WaterStateCopyWithImpl(
      _$_WaterState _value, $Res Function(_$_WaterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? glasses = freezed,
    Object? isSaved = null,
    Object? status = null,
  }) {
    return _then(_$_WaterState(
      glasses: freezed == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as WaterModel?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }
}

/// @nodoc

class _$_WaterState implements _WaterState {
  _$_WaterState(
      {this.glasses, this.isSaved = false, this.status = Status.initial});

  @override
  final WaterModel? glasses;
  @override
  @JsonKey()
  final bool isSaved;
  @override
  @JsonKey()
  final Status status;

  @override
  String toString() {
    return 'WaterState(glasses: $glasses, isSaved: $isSaved, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WaterState &&
            (identical(other.glasses, glasses) || other.glasses == glasses) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, glasses, isSaved, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WaterStateCopyWith<_$_WaterState> get copyWith =>
      __$$_WaterStateCopyWithImpl<_$_WaterState>(this, _$identity);
}

abstract class _WaterState implements WaterState {
  factory _WaterState(
      {final WaterModel? glasses,
      final bool isSaved,
      final Status status}) = _$_WaterState;

  @override
  WaterModel? get glasses;
  @override
  bool get isSaved;
  @override
  Status get status;
  @override
  @JsonKey(ignore: true)
  _$$_WaterStateCopyWith<_$_WaterState> get copyWith =>
      throw _privateConstructorUsedError;
}

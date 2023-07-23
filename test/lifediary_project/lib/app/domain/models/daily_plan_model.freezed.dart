// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyPlanModel {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get time => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyPlanModelCopyWith<DailyPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPlanModelCopyWith<$Res> {
  factory $DailyPlanModelCopyWith(
          DailyPlanModel value, $Res Function(DailyPlanModel) then) =
      _$DailyPlanModelCopyWithImpl<$Res, DailyPlanModel>;
  @useResult
  $Res call({String id, String text, String time});
}

/// @nodoc
class _$DailyPlanModelCopyWithImpl<$Res, $Val extends DailyPlanModel>
    implements $DailyPlanModelCopyWith<$Res> {
  _$DailyPlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? time = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyPlanModelCopyWith<$Res>
    implements $DailyPlanModelCopyWith<$Res> {
  factory _$$_DailyPlanModelCopyWith(
          _$_DailyPlanModel value, $Res Function(_$_DailyPlanModel) then) =
      __$$_DailyPlanModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String text, String time});
}

/// @nodoc
class __$$_DailyPlanModelCopyWithImpl<$Res>
    extends _$DailyPlanModelCopyWithImpl<$Res, _$_DailyPlanModel>
    implements _$$_DailyPlanModelCopyWith<$Res> {
  __$$_DailyPlanModelCopyWithImpl(
      _$_DailyPlanModel _value, $Res Function(_$_DailyPlanModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? time = null,
  }) {
    return _then(_$_DailyPlanModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_DailyPlanModel implements _DailyPlanModel {
  _$_DailyPlanModel({required this.id, this.text = '', required this.time});

  @override
  final String id;
  @override
  @JsonKey()
  final String text;
  @override
  final String time;

  @override
  String toString() {
    return 'DailyPlanModel(id: $id, text: $text, time: $time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyPlanModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.time, time) || other.time == time));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, text, time);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyPlanModelCopyWith<_$_DailyPlanModel> get copyWith =>
      __$$_DailyPlanModelCopyWithImpl<_$_DailyPlanModel>(this, _$identity);
}

abstract class _DailyPlanModel implements DailyPlanModel {
  factory _DailyPlanModel(
      {required final String id,
      final String text,
      required final String time}) = _$_DailyPlanModel;

  @override
  String get id;
  @override
  String get text;
  @override
  String get time;
  @override
  @JsonKey(ignore: true)
  _$$_DailyPlanModelCopyWith<_$_DailyPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'water_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WaterModel {
  String get id => throw _privateConstructorUsedError;
  String get glasses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WaterModelCopyWith<WaterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaterModelCopyWith<$Res> {
  factory $WaterModelCopyWith(
          WaterModel value, $Res Function(WaterModel) then) =
      _$WaterModelCopyWithImpl<$Res, WaterModel>;
  @useResult
  $Res call({String id, String glasses});
}

/// @nodoc
class _$WaterModelCopyWithImpl<$Res, $Val extends WaterModel>
    implements $WaterModelCopyWith<$Res> {
  _$WaterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? glasses = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      glasses: null == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WaterModelCopyWith<$Res>
    implements $WaterModelCopyWith<$Res> {
  factory _$$_WaterModelCopyWith(
          _$_WaterModel value, $Res Function(_$_WaterModel) then) =
      __$$_WaterModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String glasses});
}

/// @nodoc
class __$$_WaterModelCopyWithImpl<$Res>
    extends _$WaterModelCopyWithImpl<$Res, _$_WaterModel>
    implements _$$_WaterModelCopyWith<$Res> {
  __$$_WaterModelCopyWithImpl(
      _$_WaterModel _value, $Res Function(_$_WaterModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? glasses = null,
  }) {
    return _then(_$_WaterModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      glasses: null == glasses
          ? _value.glasses
          : glasses // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_WaterModel implements _WaterModel {
  _$_WaterModel({this.id = '', this.glasses = ''});

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String glasses;

  @override
  String toString() {
    return 'WaterModel(id: $id, glasses: $glasses)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WaterModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.glasses, glasses) || other.glasses == glasses));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, glasses);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WaterModelCopyWith<_$_WaterModel> get copyWith =>
      __$$_WaterModelCopyWithImpl<_$_WaterModel>(this, _$identity);
}

abstract class _WaterModel implements WaterModel {
  factory _WaterModel({final String id, final String glasses}) = _$_WaterModel;

  @override
  String get id;
  @override
  String get glasses;
  @override
  @JsonKey(ignore: true)
  _$$_WaterModelCopyWith<_$_WaterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

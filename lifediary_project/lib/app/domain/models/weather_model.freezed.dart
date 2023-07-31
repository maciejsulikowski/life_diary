// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) {
  return _WeatherModel.fromJson(json);
}

/// @nodoc
mixin _$WeatherModel {
  Location get location => throw _privateConstructorUsedError;
  CurrentCondition get current => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherModelCopyWith<WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherModelCopyWith<$Res> {
  factory $WeatherModelCopyWith(
          WeatherModel value, $Res Function(WeatherModel) then) =
      _$WeatherModelCopyWithImpl<$Res, WeatherModel>;
  @useResult
  $Res call({Location location, CurrentCondition current});

  $LocationCopyWith<$Res> get location;
  $CurrentConditionCopyWith<$Res> get current;
}

/// @nodoc
class _$WeatherModelCopyWithImpl<$Res, $Val extends WeatherModel>
    implements $WeatherModelCopyWith<$Res> {
  _$WeatherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? current = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentCondition,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrentConditionCopyWith<$Res> get current {
    return $CurrentConditionCopyWith<$Res>(_value.current, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WeatherModelCopyWith<$Res>
    implements $WeatherModelCopyWith<$Res> {
  factory _$$_WeatherModelCopyWith(
          _$_WeatherModel value, $Res Function(_$_WeatherModel) then) =
      __$$_WeatherModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Location location, CurrentCondition current});

  @override
  $LocationCopyWith<$Res> get location;
  @override
  $CurrentConditionCopyWith<$Res> get current;
}

/// @nodoc
class __$$_WeatherModelCopyWithImpl<$Res>
    extends _$WeatherModelCopyWithImpl<$Res, _$_WeatherModel>
    implements _$$_WeatherModelCopyWith<$Res> {
  __$$_WeatherModelCopyWithImpl(
      _$_WeatherModel _value, $Res Function(_$_WeatherModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? current = null,
  }) {
    return _then(_$_WeatherModel(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      current: null == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as CurrentCondition,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WeatherModel implements _WeatherModel {
  _$_WeatherModel({required this.location, required this.current});

  factory _$_WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$$_WeatherModelFromJson(json);

  @override
  final Location location;
  @override
  final CurrentCondition current;

  @override
  String toString() {
    return 'WeatherModel(location: $location, current: $current)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WeatherModel &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.current, current) || other.current == current));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location, current);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WeatherModelCopyWith<_$_WeatherModel> get copyWith =>
      __$$_WeatherModelCopyWithImpl<_$_WeatherModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeatherModelToJson(
      this,
    );
  }
}

abstract class _WeatherModel implements WeatherModel {
  factory _WeatherModel(
      {required final Location location,
      required final CurrentCondition current}) = _$_WeatherModel;

  factory _WeatherModel.fromJson(Map<String, dynamic> json) =
      _$_WeatherModel.fromJson;

  @override
  Location get location;
  @override
  CurrentCondition get current;
  @override
  @JsonKey(ignore: true)
  _$$_WeatherModelCopyWith<_$_WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res, Location>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(
          _$_Location value, $Res Function(_$_Location) then) =
      __$$_LocationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res>
    extends _$LocationCopyWithImpl<$Res, _$_Location>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(
      _$_Location _value, $Res Function(_$_Location) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$_Location(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location implements _Location {
  _$_Location({required this.name});

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$$_LocationFromJson(json);

  @override
  final String name;

  @override
  String toString() {
    return 'Location(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  factory _Location({required final String name}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrentCondition _$CurrentConditionFromJson(Map<String, dynamic> json) {
  return _CurrentCondition.fromJson(json);
}

/// @nodoc
mixin _$CurrentCondition {
  double get temp_c => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrentConditionCopyWith<CurrentCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentConditionCopyWith<$Res> {
  factory $CurrentConditionCopyWith(
          CurrentCondition value, $Res Function(CurrentCondition) then) =
      _$CurrentConditionCopyWithImpl<$Res, CurrentCondition>;
  @useResult
  $Res call({double temp_c});
}

/// @nodoc
class _$CurrentConditionCopyWithImpl<$Res, $Val extends CurrentCondition>
    implements $CurrentConditionCopyWith<$Res> {
  _$CurrentConditionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp_c = null,
  }) {
    return _then(_value.copyWith(
      temp_c: null == temp_c
          ? _value.temp_c
          : temp_c // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrentConditionCopyWith<$Res>
    implements $CurrentConditionCopyWith<$Res> {
  factory _$$_CurrentConditionCopyWith(
          _$_CurrentCondition value, $Res Function(_$_CurrentCondition) then) =
      __$$_CurrentConditionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double temp_c});
}

/// @nodoc
class __$$_CurrentConditionCopyWithImpl<$Res>
    extends _$CurrentConditionCopyWithImpl<$Res, _$_CurrentCondition>
    implements _$$_CurrentConditionCopyWith<$Res> {
  __$$_CurrentConditionCopyWithImpl(
      _$_CurrentCondition _value, $Res Function(_$_CurrentCondition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp_c = null,
  }) {
    return _then(_$_CurrentCondition(
      temp_c: null == temp_c
          ? _value.temp_c
          : temp_c // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrentCondition extends _CurrentCondition {
  _$_CurrentCondition({required this.temp_c}) : super._();

  factory _$_CurrentCondition.fromJson(Map<String, dynamic> json) =>
      _$$_CurrentConditionFromJson(json);

  @override
  final double temp_c;

  @override
  String toString() {
    return 'CurrentCondition(temp_c: $temp_c)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentCondition &&
            (identical(other.temp_c, temp_c) || other.temp_c == temp_c));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, temp_c);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrentConditionCopyWith<_$_CurrentCondition> get copyWith =>
      __$$_CurrentConditionCopyWithImpl<_$_CurrentCondition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrentConditionToJson(
      this,
    );
  }
}

abstract class _CurrentCondition extends CurrentCondition {
  factory _CurrentCondition({required final double temp_c}) =
      _$_CurrentCondition;
  _CurrentCondition._() : super._();

  factory _CurrentCondition.fromJson(Map<String, dynamic> json) =
      _$_CurrentCondition.fromJson;

  @override
  double get temp_c;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentConditionCopyWith<_$_CurrentCondition> get copyWith =>
      throw _privateConstructorUsedError;
}

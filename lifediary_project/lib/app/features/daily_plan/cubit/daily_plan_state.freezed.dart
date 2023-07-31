// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_plan_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DailyPlanState {
  List<DailyPlanModel> get list => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isSaved => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DailyPlanStateCopyWith<DailyPlanState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPlanStateCopyWith<$Res> {
  factory $DailyPlanStateCopyWith(
          DailyPlanState value, $Res Function(DailyPlanState) then) =
      _$DailyPlanStateCopyWithImpl<$Res, DailyPlanState>;
  @useResult
  $Res call(
      {List<DailyPlanModel> list,
      Status status,
      String? errorMessage,
      bool isSaved});
}

/// @nodoc
class _$DailyPlanStateCopyWithImpl<$Res, $Val extends DailyPlanState>
    implements $DailyPlanStateCopyWith<$Res> {
  _$DailyPlanStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isSaved = null,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<DailyPlanModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DailyPlanStateCopyWith<$Res>
    implements $DailyPlanStateCopyWith<$Res> {
  factory _$$_DailyPlanStateCopyWith(
          _$_DailyPlanState value, $Res Function(_$_DailyPlanState) then) =
      __$$_DailyPlanStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<DailyPlanModel> list,
      Status status,
      String? errorMessage,
      bool isSaved});
}

/// @nodoc
class __$$_DailyPlanStateCopyWithImpl<$Res>
    extends _$DailyPlanStateCopyWithImpl<$Res, _$_DailyPlanState>
    implements _$$_DailyPlanStateCopyWith<$Res> {
  __$$_DailyPlanStateCopyWithImpl(
      _$_DailyPlanState _value, $Res Function(_$_DailyPlanState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? isSaved = null,
  }) {
    return _then(_$_DailyPlanState(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<DailyPlanModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSaved: null == isSaved
          ? _value.isSaved
          : isSaved // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DailyPlanState implements _DailyPlanState {
  _$_DailyPlanState(
      {final List<DailyPlanModel> list = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.isSaved = false})
      : _list = list;

  final List<DailyPlanModel> _list;
  @override
  @JsonKey()
  List<DailyPlanModel> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isSaved;

  @override
  String toString() {
    return 'DailyPlanState(list: $list, status: $status, errorMessage: $errorMessage, isSaved: $isSaved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DailyPlanState &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isSaved, isSaved) || other.isSaved == isSaved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_list),
      status,
      errorMessage,
      isSaved);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DailyPlanStateCopyWith<_$_DailyPlanState> get copyWith =>
      __$$_DailyPlanStateCopyWithImpl<_$_DailyPlanState>(this, _$identity);
}

abstract class _DailyPlanState implements DailyPlanState {
  factory _DailyPlanState(
      {final List<DailyPlanModel> list,
      final Status status,
      final String? errorMessage,
      final bool isSaved}) = _$_DailyPlanState;

  @override
  List<DailyPlanModel> get list;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  bool get isSaved;
  @override
  @JsonKey(ignore: true)
  _$$_DailyPlanStateCopyWith<_$_DailyPlanState> get copyWith =>
      throw _privateConstructorUsedError;
}

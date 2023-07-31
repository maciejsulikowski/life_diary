// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diares_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DiaresState {
  List<ItemModel> get items => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiaresStateCopyWith<DiaresState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaresStateCopyWith<$Res> {
  factory $DiaresStateCopyWith(
          DiaresState value, $Res Function(DiaresState) then) =
      _$DiaresStateCopyWithImpl<$Res, DiaresState>;
  @useResult
  $Res call({List<ItemModel> items, Status status, String? errorMessage});
}

/// @nodoc
class _$DiaresStateCopyWithImpl<$Res, $Val extends DiaresState>
    implements $DiaresStateCopyWith<$Res> {
  _$DiaresStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiaresStateCopyWith<$Res>
    implements $DiaresStateCopyWith<$Res> {
  factory _$$_DiaresStateCopyWith(
          _$_DiaresState value, $Res Function(_$_DiaresState) then) =
      __$$_DiaresStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ItemModel> items, Status status, String? errorMessage});
}

/// @nodoc
class __$$_DiaresStateCopyWithImpl<$Res>
    extends _$DiaresStateCopyWithImpl<$Res, _$_DiaresState>
    implements _$$_DiaresStateCopyWith<$Res> {
  __$$_DiaresStateCopyWithImpl(
      _$_DiaresState _value, $Res Function(_$_DiaresState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? status = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$_DiaresState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DiaresState implements _DiaresState {
  _$_DiaresState(
      {final List<ItemModel> items = const [],
      this.status = Status.initial,
      this.errorMessage})
      : _items = items;

  final List<ItemModel> _items;
  @override
  @JsonKey()
  List<ItemModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'DiaresState(items: $items, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiaresState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), status, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiaresStateCopyWith<_$_DiaresState> get copyWith =>
      __$$_DiaresStateCopyWithImpl<_$_DiaresState>(this, _$identity);
}

abstract class _DiaresState implements DiaresState {
  factory _DiaresState(
      {final List<ItemModel> items,
      final Status status,
      final String? errorMessage}) = _$_DiaresState;

  @override
  List<ItemModel> get items;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$_DiaresStateCopyWith<_$_DiaresState> get copyWith =>
      throw _privateConstructorUsedError;
}

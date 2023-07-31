// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'to_do_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ToDoListState {
  List<ItemModelToDoList> get documents => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get saved => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ToDoListStateCopyWith<ToDoListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ToDoListStateCopyWith<$Res> {
  factory $ToDoListStateCopyWith(
          ToDoListState value, $Res Function(ToDoListState) then) =
      _$ToDoListStateCopyWithImpl<$Res, ToDoListState>;
  @useResult
  $Res call(
      {List<ItemModelToDoList> documents,
      Status status,
      String? errorMessage,
      bool saved,
      bool isChecked});
}

/// @nodoc
class _$ToDoListStateCopyWithImpl<$Res, $Val extends ToDoListState>
    implements $ToDoListStateCopyWith<$Res> {
  _$ToDoListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
    Object? isChecked = null,
  }) {
    return _then(_value.copyWith(
      documents: null == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<ItemModelToDoList>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ToDoListStateCopyWith<$Res>
    implements $ToDoListStateCopyWith<$Res> {
  factory _$$_ToDoListStateCopyWith(
          _$_ToDoListState value, $Res Function(_$_ToDoListState) then) =
      __$$_ToDoListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ItemModelToDoList> documents,
      Status status,
      String? errorMessage,
      bool saved,
      bool isChecked});
}

/// @nodoc
class __$$_ToDoListStateCopyWithImpl<$Res>
    extends _$ToDoListStateCopyWithImpl<$Res, _$_ToDoListState>
    implements _$$_ToDoListStateCopyWith<$Res> {
  __$$_ToDoListStateCopyWithImpl(
      _$_ToDoListState _value, $Res Function(_$_ToDoListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documents = null,
    Object? status = null,
    Object? errorMessage = freezed,
    Object? saved = null,
    Object? isChecked = null,
  }) {
    return _then(_$_ToDoListState(
      documents: null == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<ItemModelToDoList>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      saved: null == saved
          ? _value.saved
          : saved // ignore: cast_nullable_to_non_nullable
              as bool,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ToDoListState implements _ToDoListState {
  _$_ToDoListState(
      {final List<ItemModelToDoList> documents = const [],
      this.status = Status.initial,
      this.errorMessage,
      this.saved = false,
      this.isChecked = false})
      : _documents = documents;

  final List<ItemModelToDoList> _documents;
  @override
  @JsonKey()
  List<ItemModelToDoList> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  @JsonKey()
  final Status status;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool saved;
  @override
  @JsonKey()
  final bool isChecked;

  @override
  String toString() {
    return 'ToDoListState(documents: $documents, status: $status, errorMessage: $errorMessage, saved: $saved, isChecked: $isChecked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ToDoListState &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.saved, saved) || other.saved == saved) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_documents),
      status,
      errorMessage,
      saved,
      isChecked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ToDoListStateCopyWith<_$_ToDoListState> get copyWith =>
      __$$_ToDoListStateCopyWithImpl<_$_ToDoListState>(this, _$identity);
}

abstract class _ToDoListState implements ToDoListState {
  factory _ToDoListState(
      {final List<ItemModelToDoList> documents,
      final Status status,
      final String? errorMessage,
      final bool saved,
      final bool isChecked}) = _$_ToDoListState;

  @override
  List<ItemModelToDoList> get documents;
  @override
  Status get status;
  @override
  String? get errorMessage;
  @override
  bool get saved;
  @override
  bool get isChecked;
  @override
  @JsonKey(ignore: true)
  _$$_ToDoListStateCopyWith<_$_ToDoListState> get copyWith =>
      throw _privateConstructorUsedError;
}

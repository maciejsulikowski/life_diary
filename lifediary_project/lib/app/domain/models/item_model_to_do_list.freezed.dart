// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model_to_do_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ItemModelToDoList {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isChecked => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemModelToDoListCopyWith<ItemModelToDoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelToDoListCopyWith<$Res> {
  factory $ItemModelToDoListCopyWith(
          ItemModelToDoList value, $Res Function(ItemModelToDoList) then) =
      _$ItemModelToDoListCopyWithImpl<$Res, ItemModelToDoList>;
  @useResult
  $Res call({String id, String title, bool isChecked});
}

/// @nodoc
class _$ItemModelToDoListCopyWithImpl<$Res, $Val extends ItemModelToDoList>
    implements $ItemModelToDoListCopyWith<$Res> {
  _$ItemModelToDoListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isChecked = null,
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
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemModelToDoListCopyWith<$Res>
    implements $ItemModelToDoListCopyWith<$Res> {
  factory _$$_ItemModelToDoListCopyWith(_$_ItemModelToDoList value,
          $Res Function(_$_ItemModelToDoList) then) =
      __$$_ItemModelToDoListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, bool isChecked});
}

/// @nodoc
class __$$_ItemModelToDoListCopyWithImpl<$Res>
    extends _$ItemModelToDoListCopyWithImpl<$Res, _$_ItemModelToDoList>
    implements _$$_ItemModelToDoListCopyWith<$Res> {
  __$$_ItemModelToDoListCopyWithImpl(
      _$_ItemModelToDoList _value, $Res Function(_$_ItemModelToDoList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isChecked = null,
  }) {
    return _then(_$_ItemModelToDoList(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isChecked: null == isChecked
          ? _value.isChecked
          : isChecked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ItemModelToDoList implements _ItemModelToDoList {
  _$_ItemModelToDoList(
      {required this.id, required this.title, this.isChecked = false});

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final bool isChecked;

  @override
  String toString() {
    return 'ItemModelToDoList(id: $id, title: $title, isChecked: $isChecked)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemModelToDoList &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isChecked, isChecked) ||
                other.isChecked == isChecked));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, isChecked);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemModelToDoListCopyWith<_$_ItemModelToDoList> get copyWith =>
      __$$_ItemModelToDoListCopyWithImpl<_$_ItemModelToDoList>(
          this, _$identity);
}

abstract class _ItemModelToDoList implements ItemModelToDoList {
  factory _ItemModelToDoList(
      {required final String id,
      required final String title,
      final bool isChecked}) = _$_ItemModelToDoList;

  @override
  String get id;
  @override
  String get title;
  @override
  bool get isChecked;
  @override
  @JsonKey(ignore: true)
  _$$_ItemModelToDoListCopyWith<_$_ItemModelToDoList> get copyWith =>
      throw _privateConstructorUsedError;
}

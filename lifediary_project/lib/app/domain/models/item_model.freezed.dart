// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ItemModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageURL => throw _privateConstructorUsedError;
  DateTime get releaseDate => throw _privateConstructorUsedError;
  List<dynamic> get text => throw _privateConstructorUsedError;
  quill.QuillController? get textFormat => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ItemModelCopyWith<ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) then) =
      _$ItemModelCopyWithImpl<$Res, ItemModel>;
  @useResult
  $Res call(
      {String id,
      String title,
      String imageURL,
      DateTime releaseDate,
      List<dynamic> text,
      quill.QuillController? textFormat});
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res, $Val extends ItemModel>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageURL = null,
    Object? releaseDate = null,
    Object? text = null,
    Object? textFormat = freezed,
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
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      textFormat: freezed == textFormat
          ? _value.textFormat
          : textFormat // ignore: cast_nullable_to_non_nullable
              as quill.QuillController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ItemModelCopyWith<$Res> implements $ItemModelCopyWith<$Res> {
  factory _$$_ItemModelCopyWith(
          _$_ItemModel value, $Res Function(_$_ItemModel) then) =
      __$$_ItemModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String imageURL,
      DateTime releaseDate,
      List<dynamic> text,
      quill.QuillController? textFormat});
}

/// @nodoc
class __$$_ItemModelCopyWithImpl<$Res>
    extends _$ItemModelCopyWithImpl<$Res, _$_ItemModel>
    implements _$$_ItemModelCopyWith<$Res> {
  __$$_ItemModelCopyWithImpl(
      _$_ItemModel _value, $Res Function(_$_ItemModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageURL = null,
    Object? releaseDate = null,
    Object? text = null,
    Object? textFormat = freezed,
  }) {
    return _then(_$_ItemModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: null == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String,
      releaseDate: null == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value._text
          : text // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      textFormat: freezed == textFormat
          ? _value.textFormat
          : textFormat // ignore: cast_nullable_to_non_nullable
              as quill.QuillController?,
    ));
  }
}

/// @nodoc

class _$_ItemModel extends _ItemModel {
  _$_ItemModel(
      {required this.id,
      required this.title,
      required this.imageURL,
      required this.releaseDate,
      required final List<dynamic> text,
      this.textFormat})
      : _text = text,
        super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageURL;
  @override
  final DateTime releaseDate;
  final List<dynamic> _text;
  @override
  List<dynamic> get text {
    if (_text is EqualUnmodifiableListView) return _text;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_text);
  }

  @override
  final quill.QuillController? textFormat;

  @override
  String toString() {
    return 'ItemModel(id: $id, title: $title, imageURL: $imageURL, releaseDate: $releaseDate, text: $text, textFormat: $textFormat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            const DeepCollectionEquality().equals(other._text, _text) &&
            (identical(other.textFormat, textFormat) ||
                other.textFormat == textFormat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageURL, releaseDate,
      const DeepCollectionEquality().hash(_text), textFormat);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemModelCopyWith<_$_ItemModel> get copyWith =>
      __$$_ItemModelCopyWithImpl<_$_ItemModel>(this, _$identity);
}

abstract class _ItemModel extends ItemModel {
  factory _ItemModel(
      {required final String id,
      required final String title,
      required final String imageURL,
      required final DateTime releaseDate,
      required final List<dynamic> text,
      final quill.QuillController? textFormat}) = _$_ItemModel;
  _ItemModel._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageURL;
  @override
  DateTime get releaseDate;
  @override
  List<dynamic> get text;
  @override
  quill.QuillController? get textFormat;
  @override
  @JsonKey(ignore: true)
  _$$_ItemModelCopyWith<_$_ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

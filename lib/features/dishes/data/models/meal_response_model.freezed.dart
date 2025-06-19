// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealResponseModel _$MealResponseModelFromJson(Map<String, dynamic> json) {
  return _MealResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MealResponseModel {
  List<MealModel> get meals => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MealResponseModelCopyWith<MealResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealResponseModelCopyWith<$Res> {
  factory $MealResponseModelCopyWith(
          MealResponseModel value, $Res Function(MealResponseModel) then) =
      _$MealResponseModelCopyWithImpl<$Res, MealResponseModel>;
  @useResult
  $Res call({List<MealModel> meals});
}

/// @nodoc
class _$MealResponseModelCopyWithImpl<$Res, $Val extends MealResponseModel>
    implements $MealResponseModelCopyWith<$Res> {
  _$MealResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
  }) {
    return _then(_value.copyWith(
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<MealModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealResponseModelImplCopyWith<$Res>
    implements $MealResponseModelCopyWith<$Res> {
  factory _$$MealResponseModelImplCopyWith(_$MealResponseModelImpl value,
          $Res Function(_$MealResponseModelImpl) then) =
      __$$MealResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MealModel> meals});
}

/// @nodoc
class __$$MealResponseModelImplCopyWithImpl<$Res>
    extends _$MealResponseModelCopyWithImpl<$Res, _$MealResponseModelImpl>
    implements _$$MealResponseModelImplCopyWith<$Res> {
  __$$MealResponseModelImplCopyWithImpl(_$MealResponseModelImpl _value,
      $Res Function(_$MealResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
  }) {
    return _then(_$MealResponseModelImpl(
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<MealModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealResponseModelImpl implements _MealResponseModel {
  const _$MealResponseModelImpl({required final List<MealModel> meals})
      : _meals = meals;

  factory _$MealResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealResponseModelImplFromJson(json);

  final List<MealModel> _meals;
  @override
  List<MealModel> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  @override
  String toString() {
    return 'MealResponseModel(meals: $meals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealResponseModelImpl &&
            const DeepCollectionEquality().equals(other._meals, _meals));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_meals));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MealResponseModelImplCopyWith<_$MealResponseModelImpl> get copyWith =>
      __$$MealResponseModelImplCopyWithImpl<_$MealResponseModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealResponseModelImplToJson(
      this,
    );
  }
}

abstract class _MealResponseModel implements MealResponseModel {
  const factory _MealResponseModel({required final List<MealModel> meals}) =
      _$MealResponseModelImpl;

  factory _MealResponseModel.fromJson(Map<String, dynamic> json) =
      _$MealResponseModelImpl.fromJson;

  @override
  List<MealModel> get meals;
  @override
  @JsonKey(ignore: true)
  _$$MealResponseModelImplCopyWith<_$MealResponseModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

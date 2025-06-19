import 'package:ai_home/features/dishes/data/models/meal_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_response_model.freezed.dart';
part 'meal_response_model.g.dart';

@freezed
class MealResponseModel with _$MealResponseModel {
  const factory MealResponseModel({
    required List<MealModel> meals,
  }) = _MealResponseModel;

  factory MealResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealResponseModelFromJson(json);
}

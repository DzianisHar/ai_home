import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dish_model.g.dart';

@JsonSerializable()
class DishModel extends Dish {
  const DishModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String imageUrl,
    List<String> ingredients = const <String>[],
    int preparationTime = 0,
    double rating = 0.0,
  }) : super(
          id: id,
          name: name,
          description: description,
          price: price,
          imageUrl: imageUrl,
          ingredients: ingredients,
          preparationTime: preparationTime,
          rating: rating,
        );

  factory DishModel.fromJson(Map<String, dynamic> json) =>
      _$DishModelFromJson(json);

  Map<String, dynamic> toJson() => _$DishModelToJson(this);
}

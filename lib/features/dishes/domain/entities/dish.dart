import 'package:equatable/equatable.dart';

class Dish extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> ingredients;
  final int preparationTime;
  final double rating;

  const Dish({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.ingredients = const <String>[],
    this.preparationTime = 0,
    this.rating = 0.0,
  });

  @override
  List<Object?> get props => <Object?>[id, name, price];

  Dish copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    List<String>? ingredients,
    int? preparationTime,
    double? rating,
  }) {
    return Dish(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      ingredients: ingredients ?? this.ingredients,
      preparationTime: preparationTime ?? this.preparationTime,
      rating: rating ?? this.rating,
    );
  }
}

import 'package:ai_home/features/dishes/data/models/dish_model.dart';

abstract class DishesDataSource {
  Future<List<DishModel>> getDishes();
}

class DishesDataSourceImpl implements DishesDataSource {
  @override
  Future<List<DishModel>> getDishes() async {
    // Simulate network delay
    await Future<void>.delayed(const Duration(seconds: 1));
    
    // Mock data - in a real app, this would come from an API
    return <DishModel>[
      const DishModel(
        id: '1',
        name: 'Truffle Pasta',
        description: 'Homemade fettuccine pasta with creamy truffle sauce, wild mushrooms, and parmesan shavings. Finished with a drizzle of truffle oil for an extra aromatic touch.',
        price: 24.99,
        imageUrl: 'https://images.pexels.com/photos/1437267/pexels-photo-1437267.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ingredients: <String>['Fresh fettuccine', 'Black truffle', 'Heavy cream', 'Wild mushrooms', 'Parmesan cheese', 'Garlic', 'Butter', 'Parsley'],
        preparationTime: 25,
        rating: 4.8,
      ),
      const DishModel(
        id: '2',
        name: 'Classic Burger',
        description: 'Juicy beef patty with cheddar cheese, crispy bacon, fresh lettuce, tomato, and special sauce on a toasted brioche bun. Served with a side of crispy fries.',
        price: 16.99,
        imageUrl: 'https://images.pexels.com/photos/1633578/pexels-photo-1633578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ingredients: <String>['Beef patty', 'Cheddar cheese', 'Bacon', 'Lettuce', 'Tomato', 'Red onion', 'Pickles', 'Brioche bun', 'Special sauce'],
        preparationTime: 15,
        rating: 4.7,
      ),
      const DishModel(
        id: '3',
        name: 'Greek Salad',
        description: 'Fresh and healthy Greek salad with crisp vegetables, feta cheese, Kalamata olives, and oregano dressing. A perfect light and refreshing choice.',
        price: 14.50,
        imageUrl: 'https://images.pexels.com/photos/1211887/pexels-photo-1211887.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ingredients: <String>['Cucumber', 'Tomatoes', 'Red onion', 'Green bell pepper', 'Kalamata olives', 'Feta cheese', 'Olive oil', 'Lemon juice', 'Oregano'],
        preparationTime: 10,
        rating: 4.5,
      ),
      const DishModel(
        id: '4',
        name: 'Pancake Stack',
        description: 'Fluffy buttermilk pancakes stacked high with fresh berries, banana slices, and drizzled with maple syrup. Topped with a dollop of whipped cream.',
        price: 12.99,
        imageUrl: 'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ingredients: <String>['Buttermilk pancakes', 'Mixed berries', 'Banana', 'Maple syrup', 'Whipped cream', 'Icing sugar'],
        preparationTime: 20,
        rating: 4.8,
      ),
      const DishModel(
        id: '5',
        name: 'Sushi Platter',
        description: 'Assorted sushi selection featuring fresh salmon, tuna, and avocado rolls. Served with wasabi, pickled ginger, and soy sauce.',
        price: 22.99,
        imageUrl: 'https://images.pexels.com/photos/2098085/pexels-photo-2098085.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
        ingredients: <String>['Sushi rice', 'Fresh salmon', 'Fresh tuna', 'Avocado', 'Nori seaweed', 'Wasabi', 'Pickled ginger', 'Soy sauce'],
        preparationTime: 25,
        rating: 4.9,
      ),
    ];
  }
}

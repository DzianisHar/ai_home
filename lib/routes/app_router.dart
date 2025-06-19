import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:ai_home/features/dishes/presentation/pages/dish_detail_page.dart';
import 'package:ai_home/features/dishes/presentation/pages/dishes_page.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const DishesPage(),
      ),
      GoRoute(
        path: '/dish/:id',
        builder: (BuildContext context, GoRouterState state) {
          final Dish dish = state.extra! as Dish;
          return DishDetailPage(dish: dish);
        },
      ),
    ],
  );
}

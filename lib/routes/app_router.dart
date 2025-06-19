import 'package:ai_home/features/dishes/presentation/pages/dish_detail_page.dart';
import 'package:ai_home/features/dishes/presentation/pages/dishes_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String homePath = '/';
  static const String dishPath = '/dish/:id';

  static String getDishPath(String id) => '/dish/$id';

  final GoRouter router = GoRouter(
    initialLocation: homePath,
    routes: <RouteBase>[
      GoRoute(
        path: homePath,
        builder: (BuildContext context, GoRouterState state) => const DishesPage(),
      ),
      GoRoute(
        path: dishPath,
        builder: (BuildContext context, GoRouterState state) {
          final mealId = state.pathParameters['id'] ?? '';
          return DishDetailPage(mealId: mealId);
        },
      ),
    ],
  );
}

import 'package:ai_home/features/dishes/domain/entities/dish.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:ai_home/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DishesPage extends StatelessWidget {
  const DishesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DishesBloc>(
      // Get the pre-initialized DishesBloc from GetIt
      create: (BuildContext context) =>
          getIt<DishesBloc>()..add(const LoadDishes()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dishes'),
          centerTitle: true,
        ),
        body: BlocBuilder<DishesBloc, DishesState>(
          builder: (BuildContext context, DishesState state) {
            if (state is DishesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DishesError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is DishesLoaded) {
              return _DishesList(dishes: state.dishes);
            }
            return const Center(child: Text('No dishes available'));
          },
        ),
      ),
    );
  }
}

class _DishesList extends StatelessWidget {
  final List<Dish> dishes;

  const _DishesList({required this.dishes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: dishes.length,
      itemBuilder: (BuildContext context, int index) {
        final Dish dish = dishes[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.r),
          child: ListTile(
            contentPadding: EdgeInsets.all(16.r),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                dish.imageUrl,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 80.w,
                    height: 80.h,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Container(
                  width: 80.w,
                  height: 80.h,
                  color: Colors.grey[300],
                  child: const Icon(Icons.fastfood, color: Colors.grey),
                ),
              ),
            ),
            title: Text(dish.name),
            subtitle: Text(
              dish.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              '\$${dish.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onTap: () {
              context.push(
                '/dish/${dish.id}',
                extra: dish,
              );
            },
          ),
        );
      },
    );
  }
}

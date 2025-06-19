import 'package:ai_home/features/dishes/data/models/meal_response_model.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ai_home/features/dishes/presentation/bloc/dishes_bloc.dart';
import 'package:ai_home/features/dishes/presentation/bloc/dishes_event.dart';
import 'package:ai_home/features/dishes/presentation/widgets/meals_list.dart';

class DishesPage extends StatefulWidget {
  final String? category;

  const DishesPage({
    super.key,
    this.category,
  });

  @override
  State<DishesPage> createState() => _DishesPageState();
}

class _DishesPageState extends State<DishesPage> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Load initial data when the page is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<DishesBloc>().state;
      if (state is! RandomMealsLoaded) {
        context.read<DishesBloc>().add(const LoadRandomMeals(count: 10));
      }
    });
  }

  void _loadInitialMeals() {
    final state = context.read<DishesBloc>().state;
    
    // Only load if we don't already have data
    if (!(state is RandomMealsLoaded || 
          state is MealsSearched || 
          state is MealsByCategoryLoaded)) {
      if (widget.category != null) {
        context.read<DishesBloc>().add(LoadMealsByCategory(widget.category!));
      } else {
        context.read<DishesBloc>().add(const LoadRandomMeals(count: 10));
      }
    }
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<DishesBloc>().add(const LoadRandomMeals(count: 10));
    } else {
      context.read<DishesBloc>().add(SearchMeals(query));
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: MealsList(category: widget.category),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      // backgroundColor: _isSearching ? Colors.white : Theme.of(context).primaryColor,
      title: _isSearching
          ? Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search meals...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: _onSearchChanged,
              ),
            )
          : Text(widget.category ?? 'Meals'),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: _isSearching ? Colors.black : Colors.black,
          ),
          onPressed: () {
            setState(() {
              if (_isSearching) {
                _searchController.clear();
                _onSearchChanged('');
              }
              _isSearching = !_isSearching;
            });
          },
        ),
      ],
    );
  }


}

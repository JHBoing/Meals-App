import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {

  final List<Meal> favoriteMeals;

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet. Add some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, i) {
          return MealItem(
            favoriteMeals[i].id,
            favoriteMeals[i].title,
            favoriteMeals[i].imageUrl,
            favoriteMeals[i].duration,
            favoriteMeals[i].complexity,
            favoriteMeals[i].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
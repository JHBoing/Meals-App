import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../dummy-data.dart';

class CategoryMealsScreen extends StatelessWidget {
  
  static const routeName = '/category-meals';
 
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryMeal = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(routeArgs['id']);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title'])
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return MealItem(
            categoryMeal[i].id,
            categoryMeal[i].title,
            categoryMeal[i].imageUrl,
            categoryMeal[i].duration,
            categoryMeal[i].complexity,
            categoryMeal[i].affordability
          );
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}
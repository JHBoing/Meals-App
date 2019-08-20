import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  List<Meal> displayedMeals;
  Map<String, String> routeArgs;
  bool _loadedInitData = false;

  void initState() {
    
    super.initState();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(routeArgs['id']);
      }).toList();
      _loadedInitData = true;
    }
    
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(routeArgs['title'])
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return MealItem(
            displayedMeals[i].id,
            displayedMeals[i].title,
            displayedMeals[i].imageUrl,
            displayedMeals[i].duration,
            displayedMeals[i].complexity,
            displayedMeals[i].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
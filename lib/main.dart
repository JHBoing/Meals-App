import 'package:flutter/material.dart';
import 'package:meals_app/dummy-data.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';

void main() => runApp(MealsApp());

class MealsApp extends StatefulWidget {

  @override
  _MealsAppState createState() => _MealsAppState();
}

class _MealsAppState extends State<MealsApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];


  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where( (meal) {
      
        if(_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }

        if(_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }

        if(_filters['vegan'] && !meal.isVegan) {
          return false;
        }

        if(_filters['vegetarian'] && !meal.isLactoseFree) {
          return false;
        }

        return true;

      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere( (meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(color: Color.fromRGBO(20, 51, 1, 1)),
          body2: TextStyle(color: Color.fromRGBO(20, 51, 1, 1)),
          title: TextStyle(
            fontSize: 18,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      //home:  CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(_availableMeals), 
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavorite, isMealFavorite),
        FilterScreen.routeName: (context) => FilterScreen(_setFilters, _filters),
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(       
        child: Text("Navigation time!")
      )
    );
  }
}

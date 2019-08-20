import 'package:flutter/material.dart';
import '../dummy-data.dart';

class MealDetailScreen extends StatelessWidget {

  static const routeName = '/meal-detail';
  
  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(title: Text(selectMeal.title),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300, width: double.infinity,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover
              )
            ),
            buildSectionTitle(context, 'Ingredients'),
            Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, i) => Text(
                  '- ${selectMeal.ingredients[i]}'
                ),
                itemCount: selectMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            Container(
              height: 200,
              width: 300,
              child: ListView.builder(
                itemBuilder: (context, i) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${(i+1)}'),
                      ),
                      title: Text(selectMeal.steps[i]),
                    ),
                    Divider()
                  ], 
                ),
                itemCount: selectMeal.steps.length,
              ),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.favorite : Icons.favorite_border
        ),
        onPressed: () => toggleFavorite(mealId)
      ),
    );
  }
}
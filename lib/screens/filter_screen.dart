import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {

  static const routeName = "/filters";

  Map<String, bool> currentFilters;

  final Function saveFilters;

  FilterScreen(this.saveFilters, this.currentFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  bool _vegetarian = false;
  bool _vegan = false;
  bool _glutenFree = false;
  bool _lactoseFree = false; 

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegetarian = widget.currentFilters['vegetarian'];

    super.initState();
  } 

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue, Function updateValueHandler ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValueHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed:() {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
              Navigator.of(context).popAndPushNamed('/');
            }  
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile('Gluten-free', 'Only include gluten-free meals', _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }
                ),
                _buildSwitchListTile('Lactose-free', 'Only include lactose-free meals', _lactoseFree,
                  (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }
                ),
                _buildSwitchListTile('Vegetarian', 'Only include vegetarian meals', _vegetarian,
                  (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }
                ),
                _buildSwitchListTile('Vegan', 'Only include vegan meals', _vegan,
                  (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }
                )
              ],
            )
          )
        ],
      )
    );
  }
}
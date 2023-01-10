import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  // changed to a statefull to update preferences

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  //receiving pointer to update filters
  FiltersScreen(this.currentFilters, this.saveFilters);

  static const routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  // state created when page loaded will set bool values to current state of filters
  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _vegetarian = widget.currentFilters['vegetarian'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // auto creates a return arrow which pops route in stack
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            // ref to widget bc Funcion is stored in a proppertie of this widget not the state
            // reach out to the widget's propperties inside of the state objects in a state classes
            onPressed: () {
              final selectecFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectecFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer:
          const MainDrawer(), // calling of drawer only adds routes to the stack
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Adjust your meal selection.',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Expanded(
            // as much space it can gets from its surroundings
            child: ListView(
          // not builder used for fixed amount
          children: <Widget>[
            _buildSwitchListTile(
                'Gluten Free.', 'Only includes Gluten-free meals.', _glutenFree,
                (newValue) {
              setState(
                () {
                  _glutenFree = newValue;
                },
              );
            }),
            _buildSwitchListTile(
                'Vegetarian.', 'Only includes vegetarian meals.', _vegetarian,
                (newValue) {
              setState(
                () {
                  _vegetarian = newValue;
                },
              );
            }),
            _buildSwitchListTile('Vegan.', 'Only includes vegan meals.', _vegan,
                (newValue) {
              setState(
                () {
                  _vegan = newValue;
                },
              );
            }),
            _buildSwitchListTile('Lactose Free.',
                'Only includes lactose-free meals.', _lactoseFree, (newValue) {
              setState(
                () {
                  _lactoseFree = newValue;
                },
              );
            })
          ],
        )),
      ]),
    );
  }
}

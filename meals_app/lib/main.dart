import 'package:flutter/material.dart';

import './models/meal.dart';
import 'categories_props.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  // changed to stlfull to manage filter
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // store user filters with a commit buttom
  // implement model! its popper here
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  
  // meal info was managed in the dummy data class
  // sorta pointer to the meals in DUMMY_MEAL
  // cast needed, error when creatin same file with uppercase
  List<Meal> _availableMeals = DUMMY_MEALS;

  // empty list, field not considered to be within DUMMY file propperties 'not scoped to the user'
  List<Meal> _favoritedMeals = [];

  // this method gets call from inside filters screen
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      // override filters when botton triggered
      _filters = filterData;

      // FILTER . true > keep
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) {
          // same as == true
          return false; // not included
        }
        //
        if ((_filters['lactose'] == true) && !meal.isLactoseFree) {
          return false;
        }
        if ((_filters['vegan'] == true) && !meal.isVegan) {
          return false;
        }
        if ((_filters['vegetarian'] == true) && !meal.isVegetarian) {
          return false;
        }
        return true; // if not filters were set
      }).toList();
    });
  }

  // not optimal, this will rebuild all the app STATE-MANAGEMENT for bigger apps
  // favorite logic
  void _toggleFavorite(String meadId) {
    // either add or remove

    // retunrs index is found, -1 otherwise
    final existingIndex = _favoritedMeals
        .indexWhere((meal) => meadId == meal.id); // remove if found

    if (existingIndex >= 0) {
      setState(() {
        // triggers rebuild
        _favoritedMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meadId == meal.id));
      });
    }
  }

  // is favorited method
  bool _isFavorite(String id) {
    // any list method
    return _favoritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        // colorScheme: ColorScheme.fromSwatch( primarySwatch: Colors.amber),
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 25,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      // named routes passing data between routes for big apps
      // initialRoute: '/', // / is default
      routes: {
        // used for pushnamed
        // / is home

        // '/': (cnt) => const CategoriesScreen(),

        // forward favorite list since Tabs has access to favorites Screen
        '/': (cnt) => TabsScreen(_favoritedMeals), // replaceb by tabsScreen
        // less error prone approach

        // since main can reach both filters and category screens, filters should be managed here

        CategoryMealsScreen.routeName: (cnt) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (cnt) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),

        // passing funtion argument to filters screen, this would not be possible using named routes
        // passing state of current filters to filters screen
        FiltersScreen.routeName: (cnt) => FiltersScreen(_filters, _setFilters)
      },
      // for routes generated in a dynamic way
      onGenerateRoute: (settings) {
        // find args within settings
        if (settings.name == 'some-route') {
          return MaterialPageRoute(
              builder: ((context) => const CategoriesScreen()));
        }
        print(settings.arguments); // find args within settings
        // the funtions passed should return a route
        // this is executed if the app tries to go to a unregistered pushNamed route
        return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()));
      },
      // fallback route if a route isn't able to load
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()));
      }),
    );
  }
}

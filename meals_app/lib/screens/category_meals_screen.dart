import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // nedded to update meals screen when a given meal
// gets deleted
  static const routeName =
      '/category-meals'; // static can be accessed without instance

  // accept forward function
  final List<Meal> availableMeals;

  // const commented bc
  // final String categoryId;r
  // final String categoryTitle;

  // const CategoryMealsScreen(this.categoryId, this.categoryTitle);
  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // saving category and list in a variable to be updated
  String categoryTitle = ''; // mutable
  List<Meal> displayedMeals = []; // mutable

  // WORKAROUND THAT SHOULD HAVE BEEN NEDEED
  var _loadInitData = false;

  //when state gets created, all meals with given id will be created
  // used to be within Widget build
  @override
  void initState() {
    // update UI

    // extracting route arguments
    // class conects with of context to get information about routes
    // CONTEXT runs after initState error!!
    // CODE BLOCK MOVED TO didChangeDependencies
    // call set state is not nedeed bc this automatically run before build runs
    // data is create when widget gets created

    // any context related stuffs wont work in here

    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // categoryTitle = routeArgs['title'] as String;
    // final categoryId = routeArgs['id'];

    // //where returns a new iterable
    // //where and contains can be used in lists
    // displayedMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();

    super.initState();
  }

  // life cycle hook to fix initState
  // not really used but..
  // this will run before build runs
  // rus whenever dependencies of state change
  // executes when the widget it belongs to the state has been fully initialice
  // and we can tap into context
  // did change runs couple of times after initialization of state
  @override
  void didChangeDependencies() {
    if (!_loadInitData) {
      // this will make this code only runs for the first time
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] as String;
      final categoryId = routeArgs['id'];

      //where returns a new iterable
      //where and contains can be used in lists
      displayedMeals = widget.availableMeals.where((meal) {
        // available meals are managed in main so they can be filtered
        return meal.categories.contains(categoryId);
      }).toList();
    }

    _loadInitData = true;
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    // THIS CODE SHOULD OVERRIDE DIDCHANGEDEPENDENCIES AND ITS NOT DOING IT ?
    // WORKAROUND WAS ADDED ANYWAYS
    // when in this screen an items gets deleted, this will execute set state and call remove the given id
    // did states isnt being called before set state is called, which it should in the lecture
    // that will cause to load all items again but its not doing that
    setState(() {
      // triggers rebuild and update UI
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            removeItem: _removeMeal, // passing pointer to delete item
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}

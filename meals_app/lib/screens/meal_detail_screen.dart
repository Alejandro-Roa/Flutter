import 'package:flutter/material.dart';

import '../categories_props.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {super.key});

  static const routeName = '/meal-detail';

  Widget buildSelectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;

    // returns true as soon as it finds a mathching value
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ), // use id to find respective src
              ),
              buildSelectionTitle(context, 'Ingredients'),
              buildContainer(
                ListView.builder(
                  itemBuilder: ((ctx, index) => Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Text(
                            selectedMeal.ingredients[index],
                          ),
                        ),
                      )),
                  itemCount: selectedMeal.ingredients.length,
                ),
              ),
              buildSelectionTitle(context, 'Steps'),
              buildContainer(
                ListView.builder(
                  itemBuilder: ((ctx, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${(index + 1)}'),
                            ),
                            title: Text(
                              selectedMeal.steps[index],
                            ),
                          ),
                          const Divider(), // draw a line between steps
                        ],
                      )),
                  itemCount: selectedMeal.steps.length,
                ),
              ),
              ElevatedButton( // fixed cached when remove , check end of vid 183
              // solve with state management
                onPressed: () => {toggleFavorite(mealId)},
                child: isFavorite(mealId)
                    ? const Text('Remove from favorites')
                    : const Text('Add to favorites!'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.delete,
          ),
          onPressed: () {
            // return button
            Navigator.of(context)
                .pop(mealId); // removes screens on top of the stack
            // screens include a whole view of pieces of it
            // goes back
            // check .args canpop
          },
        ));
  }
}

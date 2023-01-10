import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  // one file per widget, exeption with one and only conjunction class widget
  // it does not uses state, otherwise, separe in another file
  Widget buildList(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        onTap: tapHandler //
        );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity, // all available space
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.amber,
            child: const Text(
              'Dummy text',
              style: TextStyle(
                fontWeight: FontWeight.w900, // spec.yaml defined
                fontSize: 30,
                // color: Theme.of(context).primaryColor, fix updated docs
                // decoration: BoxDecoration(color: ) // same as color arg
              ),
            ),
          ),
          // links
          const SizedBox(
            height: 20,
          ),
          buildList('Meals', Icons.restaurant, () {
            Navigator.of(context)
                .pushReplacementNamed('/'); // define links hard to misstype?
          }),
          buildList('Filters', Icons.settings, () {
            // Navigator.of(context).pushNamed(FiltersScreen.routeName);  replacement replaces current page so the
            // stack keeps its size
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}

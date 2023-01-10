import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './favorites_screen.dart';
import './categories_screen.dart';
import '../models/meal.dart';

//two way to manage tabs on flutter
class TabsScreen extends StatefulWidget {
  // accepting favorite list
  final List<Meal> favoritedMeals;

  const TabsScreen(this.favoritedMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  // cannot refer to other propperties until
  // creation of the class isnt fully finished,

  // used to access widget.fav
  @override
  void initState() {
    // will run before run executes
    // data needed
    _pages = [
      // to uptade tabs top names use a map
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      // fordwarding favoriteMeals list so favorite Screen
      // widget is available in build method, init state but not when initializing
      {'page': FavoritesScreen(widget.favoritedMeals), 'title': 'Favorites'}
    ];
    super.initState();
  }

  // control whats displayed
  int _selectedPageIndex = 0;

  // control whats selected
  void _selectPage(int index) {
    // index being page num
    setState(() {
      // update index to display new page
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //     // TOP NAVBAR //
    //  return  DefaultTabController( // one way
    //   // wiil auto switch between tabs
    //   length: 2, // how  many tabs
    //   initialIndex: 0, // sorta index list
    //   child: Scaffold(
    //     // manage entire screen with a widget
    //     // two way of adding tabs
    //     appBar: AppBar(
    //       title: const Text('Meals'),
    //       bottom: const TabBar(tabs: <Widget>[
    //         // auto connected to show right content
    //         Tab(
    //           icon: Icon(Icons.category),
    //           text: 'Categories',
    //         ),
    //         Tab(
    //           icon: Icon(Icons.star),
    //           text: 'Favorites',
    //         ),
    //       ]),
    //     ),
    //     body: const TabBarView(
    //       // adding tabbar view being used by the DefaultTabController conjuntion with appbar
    //       children: <Widget>[
    //         // as many tabs as children
    //         CategoriesScreen(),
    //         FavoritesScreen(),
    //       ],
    //     ),
    //   ),
    // );

    // BOTTOM NAVBAR

    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      // burger menu
      drawer: const MainDrawer(), // add any kind of widgets
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        // manual control desired content
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedIconTheme: const IconThemeData(color: Colors.amber),
        currentIndex: _selectedPageIndex, // pass selected info to the navbar
        type: BottomNavigationBarType
            .shifting, // adds a lil animation '' requires background styling
        items: [
          // items are tabs here
          BottomNavigationBarItem(
              // added bc of shifting
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.favorite),
              label: 'Favorites'),
        ],
      ),
    );
  }
}
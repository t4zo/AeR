import 'package:AeR/views/responsaveis/responsavel.view.dart';
import 'package:AeR/views/professores/professor.view.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _screens;
  int _selectScreenIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      _screens = [
        {'screen': ResponsavelView(), 'title': 'Responsavel'},
        {'screen': ProfessorView(), 'title': 'Professor'},
      ];
    });
  }

  void _selectScreen(int index) {
    setState(() {
      _selectScreenIndex = index;
    });
  }

  void _bottomTapped(int index) {
    setState(() {
      _selectScreenIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectScreenIndex]['title']),
      // ),
      // body: _screens[_selectScreenIndex]['screen'],
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => _selectScreen(index),
        children: _screens.map((screen) => screen['screen'] as Widget).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectScreenIndex,
        onTap: (index) => _bottomTapped(index),
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.accessibility_new),
            title: Text('Responsável'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.group),
            title: Text('Professor'),
          ),
        ],
      ),
    );
  }
}

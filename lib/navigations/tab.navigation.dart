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
      this._selectScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_screens[_selectScreenIndex]['title']),
      // ),
      body: _screens[_selectScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectScreenIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.accessibility_new),
            title: Text('Responsavel'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.group),
            title: Text('Professor'),
          ),
        ],
        onTap: _selectScreen,
      ),
    );
  }
}

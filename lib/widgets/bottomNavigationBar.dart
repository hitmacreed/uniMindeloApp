import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_mindelo/utils/colors.dart';
import 'package:uni_mindelo/utils/services/router.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          pushToView(homeRoute);
          break;
        case 1:
          pushToView(feedRoute);
          break;
        case 2:
          //pushToView(feedRoute);
          break;
        case 3:
          //pushToView()
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: bottomNavigationBarTheme,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Noticias',
            backgroundColor: bottomNavigationBarTheme),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Aulas',
          backgroundColor: bottomNavigationBarTheme,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: bottomNavigationBarTheme,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.shifting,
      onTap: _onItemTapped,
    );
  }

  void pushToView(view) {
    Navigator.pushNamed(context, view);
  }
}

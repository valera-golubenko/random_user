import 'dart:async';

import 'package:flutter/material.dart';
import 'package:random_user/pages/home/home_p.dart';
import 'package:random_user/pages/map/map_p.dart';
import 'package:random_user/pages/weather/weather_p.dart';

import '../home/models/model.dart';

class BottomSheetCustom extends StatefulWidget {
  const BottomSheetCustom({Key? key}) : super(key: key);

  @override
  _BottomSheetCustomState createState() => _BottomSheetCustomState();
}

class _BottomSheetCustomState extends State<BottomSheetCustom> {
  int _selectedTab = 0;
  final _usersPaser = StreamController<List<User>>.broadcast();
  List<User> usersMap = [];

  List<Widget> _widgetOptions() => <Widget>[
        HomeP(usersPaser: _usersPaser),
        MapP(usersMap: usersMap),
        const WeatherP(),
      ];
  _buildBottomSheet() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      backgroundColor: Colors.blue,
      currentIndex: _selectedTab,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud),
          label: 'Weather',
        ),
      ],
      onTap: onSelectTab,
    );
  }

  void onSelectTab(index) {
    if (_selectedTab == index) return;

    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _usersPaser.stream.listen((list) {
      usersMap = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions()[_selectedTab],
      bottomNavigationBar: _buildBottomSheet(),
    );
  }
}

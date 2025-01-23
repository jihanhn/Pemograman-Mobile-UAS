import 'package:flutter/material.dart';
import 'package:sleep_panda/const.dart';
import 'package:sleep_panda/screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Track the selected index

  final List<Widget> _pages = [
    Center(
      child: Text(
        'Journal Tidur',
        style: TextStyle(color: Colors.white),
      ),
    ),
    Center(
      child: Text(
        'Sleep page',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: (value) {
          setState(() {
            _currentIndex = value; // Update the selected index
          });
        },
        backgroundColor: Color(0xff272E49),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xff627EAE),
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 0
                    ? 'assets/buku.png' // Use the "buku.png" when selected
                    : 'assets/un-buku.png', // Use the "un-buku.png" when unselected
              ),
              label: 'Journal Tidur'),
          BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 1
                    ? 'assets/sleep.png' // Use the "sleep.png" when selected
                    : 'assets/un-sleep.png', // Use the "un-sleep.png" when unselected
              ),
              label: 'Sleep'),
          BottomNavigationBarItem(
              icon: Image.asset(
                _currentIndex == 2
                    ? 'assets/profile.png' // Use the "profile.png" when selected
                    : 'assets/un-profile.png', // Use the "un-profile.png" when unselected
              ),
              label: 'Profile'),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}

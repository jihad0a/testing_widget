import 'package:flutter/material.dart';
import 'feature_page.dart';
import 'profile_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FeaturePage()));
    } else if (index == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: const Text('Home Page',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onTap,
        selectedIndex: _currentIndex,
        indicatorShape: const StadiumBorder(
          side: BorderSide(color: Colors.green, width: 2.3, strokeAlign: 2),
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.house_outlined, size: 24),
            label: 'Home',
            selectedIcon: Icon(Icons.house_sharp,
                size: 30, color: Colors.deepPurpleAccent),
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined, size: 24),
            label: 'Feature',
            selectedIcon: Icon(Icons.local_fire_department_sharp,
                size: 30, color: Colors.deepPurpleAccent),
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined, size: 24),
            label: 'Profile',
            selectedIcon: Icon(Icons.account_circle_sharp,
                size: 30, color: Colors.deepPurpleAccent),
          ),
        ],
      ),
    );
  }
}

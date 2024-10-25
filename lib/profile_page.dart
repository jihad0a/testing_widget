import 'package:flutter/material.dart';
import 'package:widget/home_page.dart';
import 'feature_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int _currentIndex = 2;

  void _onTap( int index ) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Home())
      );
    } else if (index == 1) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => const FeaturePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: const Text('Profile Page', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
        ),),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('Welcome to Profile Page!', style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
            ),),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
                },
                child: const Text('Back to Home'),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(

        onDestinationSelected: _onTap,
        selectedIndex: _currentIndex,
        indicatorShape: const StadiumBorder(
            side: BorderSide(
                color: Colors.green,
                width: 2.3,
                strokeAlign: 2
            )
        ),

        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.house_outlined, size: 24,),
            label: 'Home',
            selectedIcon: Icon(
              Icons.house_sharp,
              size: 30,
              color: Colors.deepPurpleAccent,
            ),
          ),

          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined, size: 24,),
            label: 'Feature',
            selectedIcon: Icon(
              Icons.local_fire_department_sharp,
              size: 30,
              color: Colors.deepPurpleAccent,
            ),
          ),

          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined, size: 24,),
            label: 'Profile',
            selectedIcon: Icon(
              Icons.account_circle_sharp,
              size: 30,
              color: Colors.deepPurpleAccent,
            ),
          )
        ],
      ),


    );
  }
}

import 'package:flutter/material.dart';
import 'package:widget/food_page.dart';
import 'home_page.dart';
import 'profile_page.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({super.key});

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class Category {
  final IconData icon;
  final String label;
  final Widget page;

  Category({
    required this.icon,
    required this.page,
    required this.label,
  });
}


class _FeaturePageState extends State<FeaturePage> {

  int _currentIndex = 1;

  void _onTap( int index ) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Home())
      );
    } else if (index ==2) {
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }


  final List<Category> categories = [
    Category(icon: Icons.food_bank_outlined, label: "Foods", page: const FoodPage()),
    Category(icon: Icons.local_drink_outlined, label: "Drinks", page: Container()),
    Category(icon: Icons.set_meal_outlined, label: "BBQ", page: Container()),
    Category(icon: Icons.cake_outlined, label: "Desserts", page: Container()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: const Text('Feature Page', style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
        ),),
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

      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(

          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 90,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return _buildCategoryButton(categories[index], context);
          },
        ),
      ),
    );
  }
}


Widget _buildCategoryButton(Category categories,  BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(width: 1.5, color: Colors.black,),
      ),
        padding: const EdgeInsets.all(1)
    ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => categories.page));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(categories.label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black
            ),
          ),
          const SizedBox(width: 8,),
          Icon(categories.icon, size: 30, color: Colors.green,),

        ],
      )
    
  );
}






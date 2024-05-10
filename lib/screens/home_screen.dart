import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:todo_v2/screens/bin_tasks_screen.dart';
import 'package:todo_v2/screens/categories_screen.dart';
import 'package:todo_v2/screens/completed_tasks_screen.dart';
import 'package:todo_v2/screens/favorite_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;

  void onChangeScreen(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  final List<Widget> _pageOptions = [
    const CategoriesScreen(),
    const CompletedTasksScreen(),
    const FavoriteTasksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        leading: SafeArea(
          child: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              );
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Made with soul',
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Bin',
                style: TextStyle(fontSize: 20),
              ),
              leading: const Icon(Icons.delete_outline_outlined),
              onTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                    builder: (context) => const BinTasksScreen()),
                ModalRoute.withName('/'),
              ),
            ),
          ],
        ),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: GNav(
          gap: 15,
          onTabChange: (index) => onChangeScreen(index),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Categories',
            ),
            GButton(
              icon: Icons.done,
              text: 'Completed',
            ),
            GButton(
              icon: Icons.favorite,
              text: 'Favorite',
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/features/home_page/widgets/home_body.dart';
import 'package:imdb/features/watch_list/watch_list_screen.dart';
import '../profile_page/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeBody(),
    const WatchListScreen(), // Index 0
    const ProfileScreen(), // Index 1
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    // color: AppColors.primary,
                    child: Text(
                      'IMDB',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.background,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'CinemaPro',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                GestureDetector(
                  onTap: () {
                    context.push('/profileScreen');
                  },
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            )
          : null,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // 2. Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1A1A1A),
        selectedItemColor: const Color(0xFFFFD740),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },

        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

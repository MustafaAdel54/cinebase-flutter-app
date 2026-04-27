import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/features/profile_page/widgets/film_card.dart';
import 'package:imdb/features/profile_page/widgets/state_item.dart';
import 'package:imdb/shared/widgets/my_icon_button.dart';
import 'package:imdb/shared/widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  int selectedIndex = 0;
  final List<String> tabLabels = ["Activity", "Favorites", "Lists"];
  String _fullName = "Loading...";

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && mounted) {
        setState(() {
          _fullName = doc.data()?['fullName'] ?? "No Name";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
            const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.background, width: 3),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _fullName,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gold Member Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF5A4B1A)),
                        color: const Color(0xFF2B250A),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "GOLD MEMBER",
                        style: TextStyle(
                          color: Color(0xFFFFD740), // Bright gold text
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "• Member since 2021",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Edit Profile',
                        onPressed: () {
                          context.push('/editProfileScreen');
                        },
                        labelColor: AppColors.background,
                      ),
                    ),
                    SizedBox(width: 10),
                    MyIconButton(icon: Icons.more_horiz, color: Colors.white),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: StateItem(count: '200', label: 'watched'),
                    ),
                    Expanded(
                      child: StateItem(count: '300', label: 'reviews'),
                    ),
                    Expanded(
                      child: StateItem(count: '400', label: 'watchlist'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(tabLabels.length, (index) {
                        bool isActive = selectedIndex == index;
                        return InkWell(
                          onTap: () => setState(() => selectedIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: 100,
                            alignment: Alignment.center,
                            child: Text(
                              tabLabels[index],
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    // The Underline Stack
                    Stack(
                      children: [
                        Divider(
                          height: 2,
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            bool isActive = selectedIndex == index;
                            if (isActive) {
                              return Container(
                                height: 3,
                                width: 100,
                                color: AppColors.primary,
                              );
                            }
                            return SizedBox(width: 100);
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Activity",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See all",
                          style: TextStyle(
                            color: Color(0xFFFFD740),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return FilmCard();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

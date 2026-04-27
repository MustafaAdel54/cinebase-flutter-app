import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/features/watch_list/widgets/movie_grid.dart';

class WatchListScreen extends ConsumerWidget {
  const WatchListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            Row(
              children: [
                Icon(Icons.search),
                const SizedBox(width: 12),
                Icon(Icons.tune),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Favorites",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .collection('favorites')
                    .snapshots(),
                builder: (context, snapshot) {
                  final int count = snapshot.data?.docs.length ?? 0;
                  return Text(
                    "$count Movies saved",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(child: MovieGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

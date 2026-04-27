import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/features/watch_list/widgets/movie_card.dart';

class MovieGrid extends ConsumerWidget {
  const MovieGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('favorites')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Center(
            child: Text(
              "Your watchlist is empty",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          itemCount: docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 20,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final movieData = docs[index].data() as Map<String, dynamic>;
            return InkWell(
              onTap: () {
                context.push('/filmScreen/${docs[index].id}');
              },
              child: MovieCard(movieData: movieData),
            );
          },
        );
      },
    );
  }
}

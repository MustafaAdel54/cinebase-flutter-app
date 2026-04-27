import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, List<String>>((
  ref,
) {
  return FavoriteNotifier();
});

class FavoriteNotifier extends StateNotifier<List<String>> {
  FavoriteNotifier() : super([]) {
    _loadFavorites();
  }

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> _loadFavorites() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _db
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .get();
      state = doc.docs.map((d) => d.id).toList();
    }
  }

  Future<void> toggleFavorite(
    String movieID,
    Map<String, dynamic> movieData,
  ) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final docRef = _db
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(movieID);

    if (state.contains(movieID)) {
      await docRef.delete();
      state = state.where((id) => id != movieID).toList();
    } else {
      await docRef.set(movieData);
      state = [...state, movieID];
    }
  }
}

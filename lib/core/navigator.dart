import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/features/edit_profile/edit_profile_screen.dart';
import 'package:imdb/features/film_page/film_screen.dart';
import 'package:imdb/features/forget_password/forget_password_screen.dart';
import 'package:imdb/features/login/login_screen.dart';
import 'package:imdb/features/profile_page/profile_screen.dart';
import 'package:imdb/features/signup/signup_screen.dart';
import 'package:imdb/features/splash/splash_screen.dart';
import 'package:imdb/features/home_page/home_screen.dart';
import 'package:imdb/features/watch_list/watch_list_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String home = '/home';
  static const String filmScreen = '/filmScreen/:id';
  static const String watchListScreen = '/watchListScreen';
  static const String profileScreen = '/profileScreen';
  static const String editProfileScreen = '/editProfileScreen';

  static final router = GoRouter(
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(path: signup, builder: (context, state) => const SignupScreen()),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: filmScreen,
        builder: (context, state) {
          final String movieID = state.pathParameters['id']!;
          return FilmScreen(imdbID: movieID);
        },
      ),
      GoRoute(
        path: watchListScreen,
        builder: (context, state) => const WatchListScreen(),
      ),
      GoRoute(
        path: profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
    ],
    redirect: (context, state) {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn =
          state.matchedLocation == AppRouter.login ||
          state.matchedLocation == AppRouter.signup;

      if (!loggedIn && !loggingIn) return '/login';
      if (loggedIn && loggingIn) return '/home';

      return null;
    },
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((dynamic _) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

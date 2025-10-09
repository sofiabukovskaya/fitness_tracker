import 'dart:async';

import 'package:fitness_tracker/core/config/router_config/router_names.dart';
import 'package:fitness_tracker/providers/auth/auth_provider.dart';
import 'package:fitness_tracker/providers/onboarding/onboarding_provider.dart';
import 'package:fitness_tracker/screens/main_screen.dart';
import 'package:fitness_tracker/screens/onboarding_screen.dart';
import 'package:fitness_tracker/screens/profile_screen.dart';
import 'package:fitness_tracker/screens/shared_profile_screen.dart';
import 'package:fitness_tracker/screens/sign_in_screen.dart';
import 'package:fitness_tracker/screens/sign_up_screen.dart';
import 'package:fitness_tracker/screens/workout_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'redirection.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    errorBuilder:
        (context, state) =>
            Scaffold(body: Center(child: Text('Page not found'))),
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final redirect = handleRedirect(context, state, ref);
      return redirect;
    },
    routes: [
      GoRoute(
        name: RouteNames.onboarding,
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: RouteNames.signUp,
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: RouteNames.signIn,
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.workoutList,
                path: '/workout-list',
                builder: (context, state) => const WorkoutListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: RouteNames.profile,
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.sharedProfile,
        path: '/shared/profile',
        builder: (context, state) {
          final queryParams = state.uri.queryParameters;
          debugPrint('Deep link params: $queryParams');
          return SharedProfileScreen(
            profileData: queryParams,
          );
        },
      ),
    ],
  );
});

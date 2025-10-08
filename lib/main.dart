import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants.dart';
import 'providers/onboarding/onboarding_provider.dart';
import 'providers/auth/auth_provider.dart';
import 'screens/onboarding_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sh = await SharedPreferences.getInstance();
  final hasSeenOnboarding = sh.get(hasOnboardingInitialized) as bool?;

  runApp(
    ProviderScope(
      overrides: [
        hasSeenOnboardingProvider.overrideWith(
          (ref) => hasSeenOnboarding ?? false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasOnboardingSeen = ref.watch(hasSeenOnboardingProvider);
    final user = ref.watch(authProvider);

    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white70,
          surface: Color(0xFF1A237E),
          onSurface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          elevation: 0,
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1344),
        cardTheme: CardThemeData(
          color: const Color(0xFF1A237E),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.white.withValues(alpha: 0.1),
          backgroundColor: const Color(0xFF1A237E),
        ),
      ),
      home:
          hasOnboardingSeen
              ? (user?.isAuthenticated == true
                  ? const MainScreen()
                  : const SignInScreen())
              : const OnboardingScreen(),
    );
  }
}

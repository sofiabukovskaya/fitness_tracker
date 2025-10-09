part of 'router.dart';

FutureOr<String?> handleRedirect(
  BuildContext context,
  GoRouterState state,
  Ref ref,
) {
  final isSignIn = state.matchedLocation == RouteNames.signIn;
  final isSignUp = state.matchedLocation == RouteNames.signUp;
  final isOnboarding = state.matchedLocation == RouteNames.onboarding;

  if (isSignIn || isSignUp || isOnboarding) {
    return null;
  }

  final isAuthenticated = _isAuthenticated(ref);
  final hasSeenOnboarding = _hasSeenOnboarding(ref);
  if (!hasSeenOnboarding) {
    return RouteNames.onboarding;
  }
  if (!isAuthenticated) {
    return RouteNames.signIn;
  }
  return null;
}

bool _isAuthenticated(Ref ref) {
  final authUser = ref.read(authProvider);
  return authUser?.isAuthenticated == true;
}

bool _hasSeenOnboarding(Ref ref) => ref.read(hasSeenOnboardingProvider);

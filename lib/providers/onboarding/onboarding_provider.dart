import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_provider.g.dart';

@riverpod
bool hasSeenOnboarding(Ref _) {
  return false;
}

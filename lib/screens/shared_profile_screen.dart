import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/config/router_config/router_names.dart';


class SharedProfileScreen extends StatelessWidget {
  final Map<String, String> profileData;

  const SharedProfileScreen({
    super.key,
    required this.profileData,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(RouteNames.workoutList),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              profileData['name'] ?? 'User',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (profileData['bio']?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  profileData['bio']!,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(
                    value: profileData['totalWorkouts'] ?? '0',
                    label: 'Workouts',
                    icon: Icons.fitness_center,
                    theme: theme,
                  ),
                  _StatItem(
                    value: profileData['completed'] ?? '0',
                    label: 'Completed',
                    icon: Icons.check_circle,
                    theme: theme,
                  ),
                  _StatItem(
                    value: profileData['inProgress'] ?? '0',
                    label: 'In Progress',
                    icon: Icons.pending,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final ThemeData theme;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

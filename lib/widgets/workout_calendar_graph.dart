import 'package:fitness_tracker/providers/workout/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkoutCalendarGraph extends HookConsumerWidget {
  const WorkoutCalendarGraph({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String getDateKey(DateTime date) {
      return '${date.year}-${date.month}-${date.day}';
    }

    double getGraphOpacity(int workoutCount) {
      return switch (workoutCount) {
        0 => 0.1,
        1 => 0.4,
        2 => 0.7,
        _ => 1.0,
      };
    }

    final workouts = ref.watch(workoutProvider);
    final startDate = useMemoized(() {
      final initialWorkout = workouts.firstOrNull;
      if (initialWorkout == null) {
        return DateTime.now();
      }
      return initialWorkout.createdAt;
    });
    final count = useMemoized(() {
      final Map<String, int> counts = {};
      for (final workout in workouts) {
        if (workout.isCompleted) {
          continue;
        }
        final dateKey = getDateKey(workout.completedAt!);
        counts[dateKey] = (counts[dateKey] ?? 0) + 1;
      }
      return counts;
    }, [workouts],);

    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Activity Graph',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                'Last 30 days',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              children: List.generate(31, (index) {
                final date = startDate.add(Duration(days: index));
                final dateKey = getDateKey(date);
                final workoutCount = count[dateKey] ?? 0;

                final opacity = getGraphOpacity(workoutCount);

                return Expanded(
                  child: Tooltip(
                    message:
                        '2 workout${2 != 1 ? 's' : ''} on ${index + 1}/${DateTime.now().month}',
                    child: Container(
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: opacity),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

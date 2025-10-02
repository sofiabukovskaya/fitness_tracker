import 'package:fitness_tracker/providers/workout/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../enums/workout_type.dart';
import '../widgets/workout_calendar_graph.dart';
import '../widgets/workout_form_dialog.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        ref.watch(workoutProvider);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const SizedBox.shrink(),
              toolbarHeight: 170,
              flexibleSpace: const SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
                    child: WorkoutCalendarGraph(),
                  ),
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: TabBar(tabs: [Tab(text: 'Upper Body'), Tab(text: 'Lower Body')]),
              ),
            ),
            body: const TabBarView(
              children: [_WorkoutList(type: WorkoutType.upperBody), _WorkoutList(type: WorkoutType.lowerBody)],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddWorkoutDialog(context),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const WorkoutFormDialog());
  }
}

class _WorkoutList extends ConsumerWidget {
  final WorkoutType type;

  const _WorkoutList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unfilteredWorkout = ref.watch(workoutProvider);
    final workouts = unfilteredWorkout.where((w) => w.type == type).toList();

    if (workouts.isEmpty) {
      return const Center(child: Text('No workouts added yet.', style: TextStyle(color: Colors.grey)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return Card(
          child: ListTile(
            enabled: false,
            title: Text(
              workout.name,
              style: TextStyle(
                color: workout.isCompleted ? Colors.grey : Colors.white,
                decoration: workout.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              '${workout.sets} sets x ${workout.reps} reps at ${workout.weight} kg',
              style: TextStyle(
                color: workout.isCompleted ? Colors.grey : Colors.white,
                decoration: workout.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: workout.isCompleted,
                  onChanged: (_) => ref.read(workoutProvider.notifier).toggleWorkoutStatus(workout.id),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => ref.read(workoutProvider.notifier).removeWorkout(workout.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

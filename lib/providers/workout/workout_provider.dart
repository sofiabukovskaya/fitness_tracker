import 'package:fitness_tracker/models/workout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:fitness_tracker/enums/workout_type.dart';

part 'workout_provider.g.dart';

@Riverpod(keepAlive: true)
class WorkoutNotifier extends _$WorkoutNotifier {
  final _uuid = const Uuid();

  @override
  List<Workout> build() {
    return [];
  }

  void addWorkout(String name, double weight, int reps, int sets, WorkoutType type) {
    final newWorkout = Workout(
      id: _uuid.v4(),
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      isCompleted: false,
      type: type,
      createdAt: DateTime.now(),
    );
    state = [...state, newWorkout];
  }

  void toggleWorkoutStatus(String id) {
    state = [
      for (final workout in state)
        if (workout.id == id)
          workout.copyWith(isCompleted: !workout.isCompleted, completedAt: workout.isCompleted ? null : DateTime.now())
        else
          workout,
    ];
  }

  void removeWorkout(String id) {
    state = state.where((workout) => workout.id != id).toList();
  }
}

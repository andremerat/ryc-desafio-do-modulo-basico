import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ryc_desafio_modulo_basico/features/task/domain/entities/task.dart';
import 'package:ryc_desafio_modulo_basico/features/task/domain/repositories/task_repository.dart';
import 'package:injectable/injectable.dart';

part 'task_state.dart';

@injectable
class TaskCubit extends Cubit<TaskState> {
  final TaskRepository repository;
  int _coins = 10;
  int _lives = 5;

  TaskCubit(this.repository) : super(TaskInitial());

  void loadTasks() {
    emit(TaskLoading());
    try {
      final tasks = repository.getTasks();
      _checkExpiredTasks(tasks);
      emit(TaskLoaded(tasks, _coins, _lives));
    } catch (e) {
      emit(TaskError("Error loading tasks"));
    }
  }

  void addTask(Task task) {
    try {
      repository.addTask(task);
      loadTasks();
    } catch (e) {
      emit(TaskError("Error adding task"));
    }
  }

  void completeTask(Task task) {
    try {
      repository.completeTask(task);
      _coins += 5;
      loadTasks();
    } catch (e) {
      emit(TaskError("Error completing task"));
    }
  }

  void buyLife() {
    if (_coins >= 5) {
      _coins -= 5;
      _lives += 1;
      emit(TaskLoaded(repository.getTasks(), _coins, _lives));
    } else {
      emit(TaskError("Not enough coins to buy a life"));
    }
  }

  void _checkExpiredTasks(List<Task> tasks) {
    for (var task in tasks) {
      if (!task.isExpired &&
          task.date.difference(DateTime.now()).inDays < 0 &&
          !task.isCompleted) {
        _lives -= 1;
        task.isExpired = true;
      }
    }
    repository.saveTasks(tasks); // Save the updated tasks with expired status
  }
}

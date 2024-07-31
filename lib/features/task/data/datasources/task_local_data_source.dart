import 'package:ryc_desafio_modulo_basico/features/task/domain/entities/task.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class TaskLocalDataSource {
  final List<Task> _tasks = [];

  List<Task> getTasks() {
    return _tasks;
  }

  void addTask(Task task) {
    _tasks.add(task);
  }

  void completeTask(Task task) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index] = task.copyWith(isCompleted: true);
    }
  }

  void saveTasks(List<Task> tasks) {
    for (var task in tasks) {
      final index = _tasks
          .indexWhere((t) => t.title == task.title && t.date == task.date);
      if (index != -1) {
        _tasks[index] = task;
      }
    }
  }
}

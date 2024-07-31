import 'package:ryc_desafio_modulo_basico/features/task/domain/entities/task.dart';
import 'package:ryc_desafio_modulo_basico/features/task/domain/repositories/task_repository.dart';
import 'package:ryc_desafio_modulo_basico/features/task/data/datasources/task_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  List<Task> getTasks() {
    return localDataSource.getTasks();
  }

  @override
  void addTask(Task task) {
    localDataSource.addTask(task);
  }

  @override
  void completeTask(Task task) {
    localDataSource.completeTask(task);
  }

  @override
  void saveTasks(List<Task> tasks) {
    localDataSource.saveTasks(tasks);
  }
}

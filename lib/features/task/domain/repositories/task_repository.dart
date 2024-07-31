import 'package:ryc_desafio_modulo_basico/features/task/domain/entities/task.dart';

abstract class TaskRepository {
  List<Task> getTasks();
  void addTask(Task task);
  void completeTask(Task task);
  void saveTasks(
      List<Task> tasks); // Adicione este método para salvar tarefas atualizadas
}

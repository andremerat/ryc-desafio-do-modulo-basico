import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/cubit/task_cubit.dart';
import 'package:ryc_desafio_modulo_basico/injection.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
  }

  Future<void> _navigateToRegister(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/register',
        arguments: _titleController.text);
    if (result == true) {
      context
          .read<TaskCubit>()
          .loadTasks(); // Reload tasks when returning from RegisterPage
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/user.png'),
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: List.generate(
                        5,
                        (index) => Icon(Icons.favorite,
                            color: index < state.lives
                                ? Colors.red
                                : Colors.grey)),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      Text('${state.coins} coins'),
                    ],
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Digite o título da tarefa',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _navigateToRegister(context),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is TaskLoaded) {
                  final tasks = state.tasks;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.isCompleted
                                  ? Colors.green
                                  : task.isExpired
                                      ? Colors.red
                                      : null,
                            ),
                          ),
                          subtitle: Text(
                              'Dias Restantes: ${task.date.difference(DateTime.now()).inDays}'),
                          trailing: IconButton(
                            icon: Icon(
                              task.isCompleted
                                  ? Icons.check
                                  : task.isExpired
                                      ? Icons.error
                                      : Icons.pending,
                              color: task.isCompleted
                                  ? Colors.green
                                  : task.isExpired
                                      ? Colors.red
                                      : null,
                            ),
                            onPressed: task.isCompleted
                                ? null
                                : () {
                                    context
                                        .read<TaskCubit>()
                                        .completeTask(task);
                                  },
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is TaskError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('No tasks found'));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Rewards',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/rewards');
          }
        },
      ),
    );
  }
}

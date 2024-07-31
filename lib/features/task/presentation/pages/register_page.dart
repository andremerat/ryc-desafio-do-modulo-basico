import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryc_desafio_modulo_basico/features/task/domain/entities/task.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/cubit/task_cubit.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final initialTitle = ModalRoute.of(context)!.settings.arguments as String?;
    if (initialTitle != null && initialTitle.isNotEmpty) {
      _titleController.text = initialTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição da Tarefa',
              ),
            ),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Data Limite',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    selectedDate = date;
                    _dateController.text =
                        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.length >= 3 && selectedDate != null) {
                  final task = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    date: selectedDate!,
                  );
                  context.read<TaskCubit>().addTask(task);
                  Navigator.pop(context,
                      true); // Pass true to indicate that a new task was added
                } else {
                  // Mostrar mensagem de erro se título tiver menos de 3 letras ou data não estiver preenchida
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Preencha o título e data limite da tarefa')),
                  );
                }
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

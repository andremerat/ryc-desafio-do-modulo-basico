import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryc_desafio_modulo_basico/injection.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/pages/home_page.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/pages/register_page.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/pages/rewards_page.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/cubit/task_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection('dev');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskCubit>(
          create: (context) => getIt<TaskCubit>()..loadTasks(),
        ),
      ],
      child: MaterialApp(
        title: 'Desafio Módulo Básico',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/register': (context) => RegisterPage(),
          '/rewards': (context) => RewardsPage(),
        },
      ),
    );
  }
}

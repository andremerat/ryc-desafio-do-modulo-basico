import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryc_desafio_modulo_basico/features/task/presentation/cubit/task_cubit.dart';

class RewardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: ListView(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset('assets/elixir.png', height: 40, width: 40),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Elixir',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Restaura um ponto de vida.'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('5 coins'),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          context.read<TaskCubit>().buyLife();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
          if (index == 0) {
            Navigator.pushNamed(context, '/');
          }
        },
      ),
    );
  }
}

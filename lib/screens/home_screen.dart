import 'package:bloc_provider/bloc/internet_bloc/internet_bloc.dart';
import 'package:bloc_provider/bloc/internet_bloc/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: currentIndex != 0
          ? Container(
              color: Colors.white,
            )
          : Center(
              child: BlocConsumer<InternetBloc, InternetState>(
                listener: (BuildContext context, state) {
                  if (state is InternetGainState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Connected!'),
                          backgroundColor: Colors.green),
                    );
                  } else if (state is InternetLostState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Connection Lost!'),
                          backgroundColor: Colors.red),
                    );
                  }
                },
                builder: (BuildContext context, Object? state) {
                  if (state is InternetGainState) {
                    return const Text('Connected!');
                  } else if (state is InternetLostState) {
                    return const Text('Connection Lost!');
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
            ),
    );
  }
}

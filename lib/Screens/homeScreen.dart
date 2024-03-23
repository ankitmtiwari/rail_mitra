import 'package:flutter/material.dart';
import 'package:rail_mitra/Screens/pnrDetailScreen.dart';
import 'package:rail_mitra/Screens/trainScheduleScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Rail Mitraa"),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.card_membership)),
              Tab(icon: Icon(Icons.schedule_outlined)),
            ]),
          ),
          body: const TabBarView(
            children: [
              PnrDetailsScreen(),
              TrainScheduleScreen()
            ],
          ),
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rail_mitra/Provider/TainDataProvivder.dart';
import 'package:rail_mitra/Screens/homeScreen.dart';
import 'package:rail_mitra/Screens/pnrDetailScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PnrProvider()),
        ChangeNotifierProvider(create: (_) => TrainScheduleProvider())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:expence_tracker_app/home_screen.dart';



void main(){
  runApp(ExpenceTrackerApp());
}

class ExpenceTrackerApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      theme: ThemeData(
          useMaterial3: true,
          cardTheme:
          CardTheme.of(context).copyWith(
              color: Color.fromARGB(243, 159, 191, 191)),
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Color.fromARGB(235, 213, 237, 237)),
        elevatedButtonTheme: ElevatedButtonThemeData(),
      ),
      home: HomeScreen(),
    );
  }
}

//colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(
//               234, 50, 87, 191)),


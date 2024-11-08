import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'services/local_storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => LocalStorageService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task & Note Manager',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.grey[200],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.teal,
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

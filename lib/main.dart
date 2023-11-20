import 'package:employee_app/pages/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:month_year_picker/month_year_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      localizationsDelegates: [
        MonthYearPickerLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: Colors.blue, // Change this to your desired primary color
        fontFamily: 'NexaRegular', // Define your custom font
        // Define more text styles here
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // Define text styles for different elements
        ),
      ),
    );
  }
}

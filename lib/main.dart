import 'package:flutter/material.dart';
import 'package:patient_information/provider/he_activity_provider.dart';
import 'package:patient_information/provider/patient_provider.dart';
import 'package:patient_information/provider/user_provider.dart';
import 'package:patient_information/screens/user_login_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: PatientProvider()),
        ChangeNotifierProvider.value(value: HEActivityProvider()),
      ],
      child: const MaterialApp(
        title: 'The Union',
        debugShowCheckedModeBanner: false,
        home: UserLoginScreen(),
      ),
    );
  }
}

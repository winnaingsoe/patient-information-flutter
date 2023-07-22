import 'package:flutter/material.dart';
import 'package:patient_information/screens/he_activity_list_screen.dart';
import 'package:patient_information/screens/patient_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PatientListScreen()),
                  );
                },
                child: const Text('Patient')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HEActivityListScreen()),
                  );
                },
                child: const Text('HE Activity')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:patient_information/provider/patient_provider.dart';
import 'package:patient_information/screens/add_new_patient_info_screen.dart';
import 'package:provider/provider.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late PatientProvider patientProvider;
  @override
  void initState() {
    patientProvider = Provider.of<PatientProvider>(context, listen: false);

    Future.delayed(Duration.zero, () async {
      await _getPatientList();
      debugPrint('${patientProvider.patientlist.length}');
    });
    super.initState();
  }

  Future<void> _getPatientList() async {
    await patientProvider.getPatient();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Patient List'),
      ),
      body: Column(
        children: [
          Consumer<PatientProvider>(
            builder: (context, provider, _) {
              if (provider.patientlist.isNotEmpty) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: provider.patientlist.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 8,
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(children: [
                              Row(
                                children: [
                                  const Text('Name : '),
                                  Text('${provider.patientlist[index].name}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Age : '),
                                  Text('${provider.patientlist[index].age}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Sex : '),
                                  Text('${provider.patientlist[index].sex}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Refer Date : '),
                                  Text(
                                      '${provider.patientlist[index].referdate}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Township : '),
                                  Text(
                                      '${provider.patientlist[index].township}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Address : '),
                                  Text(
                                      '${provider.patientlist[index].address}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Refer From : '),
                                  Text(
                                      '${provider.patientlist[index].referfrom}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Refer To : '),
                                  Text(
                                      '${provider.patientlist[index].referto}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Sign and Symptom : '),
                                  Text(
                                      '${provider.patientlist[index].signandsymptom}'),
                                ],
                              ),
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const Expanded(
                    child: Center(
                        child: Text(
                  'No Data',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )));
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddNewPatientScreen()),
          );
        },
        tooltip: 'Add Patient',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

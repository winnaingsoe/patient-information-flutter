import 'package:flutter/material.dart';
import 'package:patient_information/models/patient.dart';
import 'package:patient_information/provider/patient_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewPatientScreen extends StatefulWidget {
  const AddNewPatientScreen({super.key});

  @override
  State<AddNewPatientScreen> createState() => _AddNewPatientScreenState();
}

class _AddNewPatientScreenState extends State<AddNewPatientScreen> {
  late var patientProvider;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? sex = 'male';
  String? township = 'AMP';
  var townships = ['AMP', 'AMT', 'CAT', 'CMT', 'PTG', 'PGT', 'MHA'];
  String? referfrom = 'Vol1';
  String? referto = 'Union';
  var refersto = ['Union', 'THD', 'Other'];
  String? signandsymptom = 'Fever';

  Future savePatientInfo(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var patient = Patient(
        name: _nameController.text,
        sex: sex,
        age: int.parse(_ageController.text),
        referdate: _dateController.text,
        township: township,
        address: _addressController.text,
        referfrom: referfrom,
        referto: referto,
        signandsymptom: signandsymptom,
      );
      patientProvider.insertPatient(patient);
      Fluttertoast.showToast(
          msg: 'Successful Save',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  void initState() {
    patientProvider = Provider.of<PatientProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _dateController.dispose();
    super.dispose();
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
        title: const Text('Add New Patient'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Name'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your name';
                    }
                    return null;
                  },
                ),
                const Text('Sex'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text("Male"),
                        Radio<String>(
                          value: 'male',
                          groupValue: sex,
                          onChanged: (String? value) {
                            setState(() {
                              sex = value.toString();
                            });
                          },
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Female"),
                        Radio<String>(
                          value: 'female',
                          groupValue: sex,
                          onChanged: (String? value) {
                            setState(() {
                              sex = value.toString();
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
                const Text('Age'),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your age',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your age';
                    } else if (int.parse(value) > 120) {
                      return '*Please enter your age is less than 120';
                    }
                    return null;
                  },
                ),
                const Text('Date'),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Enter Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                const Text('Township'),
                DropdownButtonFormField(
                  value: township,
                  decoration: const InputDecoration(),
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                  items: townships.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      township = newValue!;
                    });
                  },
                ),
                const Text('Address'),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your address',
                  ),
                  maxLength: 40,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your address';
                    }
                    return null;
                  },
                ),
                const Text('Refer From'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Vol1',
                          groupValue: referfrom,
                          onChanged: (String? value) {
                            setState(() {
                              referfrom = value.toString();
                            });
                          },
                        ),
                        Text('Vol1'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Vol2',
                          groupValue: referfrom,
                          onChanged: (String? value) {
                            setState(() {
                              referfrom = value.toString();
                            });
                          },
                        ),
                        Text('Vol2'),
                      ],
                    ),
                  ],
                ),
                const Text('Refer To'),
                DropdownButtonFormField(
                  value: referto,
                  decoration: const InputDecoration(),
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  ),
                  items: refersto.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      referto = newValue!;
                    });
                  },
                ),
                const Text('Sign and Symtptom'),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Fever'),
                      leading: Radio<String>(
                        value: 'fever',
                        groupValue: signandsymptom,
                        onChanged: (String? value) {
                          setState(() {
                            signandsymptom = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Weight Loss'),
                      leading: Radio<String>(
                        value: 'weight loss',
                        groupValue: signandsymptom,
                        onChanged: (String? value) {
                          setState(() {
                            signandsymptom = value.toString();
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Cough more than Two Week'),
                      leading: Radio<String>(
                        value: 'cough more than two week',
                        groupValue: signandsymptom,
                        onChanged: (String? value) {
                          setState(() {
                            signandsymptom = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        savePatientInfo(context);
                      },
                      child: const Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

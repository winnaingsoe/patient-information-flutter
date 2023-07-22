import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_information/models/he_activity.dart';
import 'package:patient_information/provider/he_activity_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewHEActivity extends StatefulWidget {
  const AddNewHEActivity({super.key});

  @override
  State<AddNewHEActivity> createState() => _AddNewHEActivityState();
}

class _AddNewHEActivityState extends State<AddNewHEActivity> {
  late var heActivityProvider;
  final _dateController = TextEditingController();
  final _addressController = TextEditingController();
  final _heAttendeesController = TextEditingController();
  final _maleController = TextEditingController();
  final _femaleController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? volunteer = 'Vol1';

  @override
  void initState() {
    heActivityProvider =
        Provider.of<HEActivityProvider>(context, listen: false);
    _heAttendeesController.text = 'Test';
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _addressController.dispose();
    _heAttendeesController.dispose();
    _maleController.dispose();
    _femaleController.dispose();

    super.dispose();
  }

  Future saveHEActivity(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      var activity = HEActivity(
        date: _dateController.text,
        address: _addressController.text,
        volunteer: volunteer,
        heattendedslist: _heAttendeesController.text,
        male: int.parse(_maleController.text),
        female: int.parse(_femaleController.text),
      );
      heActivityProvider.insertHEActivity(activity);
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
        title: const Text('Add New HE Activity'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Text('Volunteer'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Vol1',
                          groupValue: volunteer,
                          onChanged: (String? value) {
                            setState(() {
                              volunteer = value.toString();
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
                          groupValue: volunteer,
                          onChanged: (String? value) {
                            setState(() {
                              volunteer = value.toString();
                            });
                          },
                        ),
                        Text('Vol2'),
                      ],
                    ),
                  ],
                ),
                const Text('He Attendees List'),
                TextFormField(
                  controller: _heAttendeesController,
                  decoration: const InputDecoration(
                      //hintText: 'Enter your --',
                      ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your --';
                    }
                    return null;
                  },
                ),
                const Text('Male'),
                TextFormField(
                  controller: _maleController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your male',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your male';
                    }
                    return null;
                  },
                ),
                const Text('Female'),
                TextFormField(
                  controller: _femaleController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter your female',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter your female';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        saveHEActivity(context);
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

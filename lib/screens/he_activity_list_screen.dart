import 'package:flutter/material.dart';
import 'package:patient_information/provider/he_activity_provider.dart';
import 'package:patient_information/screens/add_new_he_activity_screen.dart';
import 'package:provider/provider.dart';

class HEActivityListScreen extends StatefulWidget {
  const HEActivityListScreen({super.key});

  @override
  State<HEActivityListScreen> createState() => _HEActivityListScreenState();
}

class _HEActivityListScreenState extends State<HEActivityListScreen> {
  late HEActivityProvider heActivityProvider;
  @override
  void initState() {
    heActivityProvider =
        Provider.of<HEActivityProvider>(context, listen: false);
    Future.delayed(Duration.zero, () async {
      await _getHEActivityList();
      debugPrint('${heActivityProvider.heactivitylist.length}');
    });
    super.initState();
  }

  Future<void> _getHEActivityList() async {
    await heActivityProvider.getHEActivity();
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
        title: const Text('HE Activity List'),
      ),
      body: Column(
        children: [
          Consumer<HEActivityProvider>(
            builder: (context, provider, _) {
              if (provider.heactivitylist.isNotEmpty) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: provider.heactivitylist.length,
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
                                  const Text('Date : '),
                                  Text(
                                      '${provider.heactivitylist[index].date}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Address : '),
                                  Text(
                                      '${provider.heactivitylist[index].address}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Volunteer : '),
                                  Text(
                                      '${provider.heactivitylist[index].volunteer}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('He Attendees List : '),
                                  Text(
                                      '${provider.heactivitylist[index].heattendedslist}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Male : '),
                                  Text(
                                      '${provider.heactivitylist[index].male}'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Female : '),
                                  Text(
                                      '${provider.heactivitylist[index].female}'),
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
            MaterialPageRoute(builder: (context) => const AddNewHEActivity()),
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

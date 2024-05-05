import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DateListScreen extends StatefulWidget {
  const DateListScreen({Key? key}) : super(key: key);

  @override
  State<DateListScreen> createState() => _DateListScreenState();
}

class _DateListScreenState extends State<DateListScreen> {
  // Sample data
  List<Map<String, dynamic>> pendingDates = [
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
    // Add more dates here
  ];

  List<Map<String, dynamic>> confirmedDates = [
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
    {
      'sender': 'John Doe',
      'time': DateTime.now(),
      'place': 'Restaurant',
      'plan': 'Dinner'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dates'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Pending dates', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: pendingDates.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        color: Colors.grey[100],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(pendingDates[index]['sender']),
                            subtitle:
                                //Parse the date to dd/mm/yyyy hh:mm format
                                Text(pendingDates[index]['time'].toString()),
                            trailing: Text(pendingDates[index]['plan']),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            const Text('Confirmed dates', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: confirmedDates.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        color: Colors.green[100],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(confirmedDates[index]['sender']),
                            subtitle:
                                //Parse the date to dd/mm/yyyy hh:mm format
                                Text(confirmedDates[index]['time'].toString()),
                            trailing: Text(confirmedDates[index]['plan']),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

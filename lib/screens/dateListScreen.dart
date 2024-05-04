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
    // Add more dates here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            itemCount: pendingDates.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ListTile(
                  title: Text(pendingDates[index]['sender']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Time: ${pendingDates[index]['time']}'),
                      Text('Place: ${pendingDates[index]['place']}'),
                      Text('Plan: ${pendingDates[index]['plan']}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

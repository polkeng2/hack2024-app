import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DateListScreen extends StatefulWidget {
  const DateListScreen({Key? key}) : super(key: key);

  @override
  State<DateListScreen> createState() => _DateListScreenState();
}

class _DateListScreenState extends State<DateListScreen> {
  // Sample data
  List<Map<String, dynamic>> pendingDates = [
    // Add more dates here
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

  List<Map<String, dynamic>> confirmedDates = [];

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
            pendingDates.isNotEmpty
                ? ListView.builder(
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
                                Slidable(
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          // Accept date
                                          setState(() {
                                            confirmedDates
                                                .add(pendingDates[index]);
                                            pendingDates.removeAt(index);
                                          });
                                        },
                                        icon: Icons.check,
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        label: 'Accept',
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          // Reject date
                                          setState(() {
                                            pendingDates.removeAt(index);
                                          });
                                        },
                                        icon: Icons.close,
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        label: 'Reject',
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(pendingDates[index]['sender']),
                                    subtitle:
                                        //Parse the date to dd/mm/yyyy hh:mm format
                                        Text(pendingDates[index]['time']
                                            .toString()),
                                    trailing: Text(pendingDates[index]['plan']),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                : Container(
                    width: double.maxFinite,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: Colors.grey[100],
                    ),
                    child: const Center(
                      child: Text('No pending dates',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
            const SizedBox(height: 20),
            const Text('Confirmed dates', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            confirmedDates.isNotEmpty
                ? ListView.builder(
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
                                      Text(confirmedDates[index]['time']
                                          .toString()),
                                  trailing: Text(confirmedDates[index]['plan']),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  )
                : Container(
                    width: double.maxFinite,
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      color: Colors.grey[100],
                    ),
                    child: const Center(
                      child: Text('No pending dates',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

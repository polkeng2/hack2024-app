import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class CustomPicker extends picker.CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, picker.LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}

class DateScreen extends StatefulWidget {
  const DateScreen({super.key});

  @override
  State<DateScreen> createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Date picker',
          textAlign: TextAlign.center,
          selectionColor: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                  child: Text('Pick a date:', style: TextStyle(fontSize: 23))),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                width: 310,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border:
                      //Apply bottom grey border
                      Border(bottom: BorderSide(color: Colors.black)),
                ),
                child: GestureDetector(
                  onTap: () {
                    picker.DatePicker.showDateTimePicker(context,
                        minTime: DateTime.now(),
                        showTitleActions: true,
                        onChanged: (date) {}, onConfirm: (date) {
                      setState(() {
                        selectedDate = date;
                      });
                    }, currentTime: DateTime.now());
                  },
                  child: Text(
                    //Display selected date in dd/mm/yyyy at hh:mm format, with the 0 in front if single digit
                    "${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year} at ${selectedDate.hour.toString().padLeft(2, '0')}:${selectedDate.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Center(
                  child: Text('Pick a place:', style: TextStyle(fontSize: 23))),
              const SizedBox(
                height: 15.0,
              ),
              const SizedBox(
                width: 310,
                child: TextField(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter a location',
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Center(
                  child: Text('Pick a plan:', style: TextStyle(fontSize: 23))),
              const SizedBox(
                height: 15.0,
              ),
              const SizedBox(
                width: 310,
                child: TextField(
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter a location',
                  ),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      // Make the button a rectangle
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/plaza',
                      );
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      // Make the button a rectangle
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      //Send request
                      Navigator.pushNamed(
                        context,
                        '/plaza',
                      );
                    },
                    child: const Text("Send request",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

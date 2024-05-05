import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String apiUrl = "https://hack.driescode.dev/";

class DateAPI {
  final int id;
  final String targetId;
  final int date;
  final String place;
  final String activity;

  DateAPI({
    required this.id,
    required this.targetId,
    required this.date,
    required this.place,
    required this.activity,
  });

  factory DateAPI.fromJson(Map<String, dynamic> json) {
    return DateAPI(
      id: json['id'],
      targetId: json['targetId'],
      date: json['date'],
      place: json['place'],
      activity: json['activity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'targetId': targetId,
      'date': date,
      'place': place,
      'activity': activity,
    };
  }

  static sendInvite(int date, String token, String place, int targetId) async {
    // Send an invite to a user
    final response = await http.post(
      Uri.parse('${apiUrl}createDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'date': date,
        'token': token,
        'place': place,
        'targetId': targetId,
      }),
    );

    if (response.statusCode == 200) {
      return DateAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send invite.');
    }
  }

  static acceptInvite(int id, int answer) async {
    // Accept an invite
    final response = await http.post(
      Uri.parse('${apiUrl}answerDate'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      return DateAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to accept invite.');
    }
  }

  static getPendingDates(String token) async {
    final response = await http.get(Uri.parse('${apiUrl}dates/$token'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load dates');
    }
  }
}

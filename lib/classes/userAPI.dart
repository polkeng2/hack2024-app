import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String apiUrl = "https://hack.driescode.dev/";

class UserAPI {
  int id;
  String token;
  final String name;
  final String hobbies;
  final int avatar;

  UserAPI({
    this.id = 0,
    this.token = "",
    required this.name,
    required this.hobbies,
    required this.avatar,
  });

  factory UserAPI.fromJson(Map<String, dynamic> json) {
    return UserAPI(
      id: json['id'],
      token: json['token'],
      name: json['name'],
      hobbies: json['hobbies'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'hobbies': hobbies,
      'avatar': avatar,
    };
  }

  static Future<UserAPI> createUser(UserAPI user) async {
    // Create a new user
    final response = await http.post(
      Uri.parse('${apiUrl}create'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      //Decode only id and token
      return UserAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user.');
    }
  }

  static Future<UserAPI> fetchMe(String token) async {
    final response = await http.get(Uri.parse('${apiUrl}user/$token'));

    if (response.statusCode == 200) {
      return UserAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<UserAPI> updateUser(UserAPI user) async {
    final response = await http.put(
      Uri.parse('${apiUrl}update/${user.token}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return UserAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user.');
    }
  }

  static fetchUser(int id) async {
    final response = await http.get(Uri.parse('${apiUrl}user/$id'));

    if (response.statusCode == 200) {
      return UserAPI.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}

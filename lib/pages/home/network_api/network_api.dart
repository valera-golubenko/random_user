import 'dart:developer';
import 'package:http/http.dart' as v;

import 'package:dio/dio.dart';
import 'package:random_user/pages/home/home_p.dart';
import 'package:random_user/pages/home/models/model.dart';

const url = 'https://randomuser.me/api/?results=15';
Future<List<User>> getData() async {
  final List<User> listUsers = [];
  // final hTtp = await v.get(Uri.parse(url));

  final response = await Dio().get(url);
  final data = response.data as Map<String, dynamic>?;
  await Future.delayed(const Duration(seconds: 1));
  if (data != null) {
    var users = data['results'];
    for (var user in users) {
      final String name = user['name']['first'] ?? 'non name';
      final int age = user['dob']['age'] ?? 0;
      final String email = user['email'] ?? 'no email';
      final String phone = user['phone'] ?? 'no phone';
      final String city = user['location']['city'] ?? 'no city';
      final String gender = user['gender'] ?? 'no gender';
      final String urlmaximg = user['picture']['large'] ?? 'no url';
      final String urlminimg = user['picture']['thumbnail'] ?? 'no url';

      final _user = User(
        name: name,
        age: age,
        email: email,
        phone: phone,
        city: city,
        gender: gender,
        urlmaximg: urlmaximg,
        urlminimg: urlminimg,
      );

      listUsers.add(_user);
    }
  }
  return listUsers;
}

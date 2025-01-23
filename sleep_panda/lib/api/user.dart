import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sleep_panda/const.dart';

Future<bool> register(String email, String password) async {
  var data = {'email': email, 'password': password};

  var client = http.Client();

  try {
    var res = await client.post(
      Uri.parse("$baseUrl/register/"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: json.encode(data),
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      print("Error: ${res.statusCode}");
      print("Response body: ${res.body}");
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  } finally {
    client.close();
  }
}

Future<bool> login(String email, String password) async {
  var data = {'email': email, 'password': password};

  var client = http.Client();

  try {
    var res = await client.post(
      Uri.parse("$baseUrl/login/"), // Replace with the correct login endpoint
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(data),
    );

    if (res.statusCode == 200) {
      print("Login successful!");
      print(
          "Response: ${res.body}"); // Optionally log the response for debugging
      return true;
    } else {
      print("Login failed with status code: ${res.statusCode}");
      print("Response body: ${res.body}");
      return false;
    }
  } catch (e) {
    print("Error: $e");
    return false;
  } finally {
    client.close();
  }
}

Future<bool> sendOtp(String email) async {
  var response = await http.post(
      Uri.parse('$baseUrl/request-otp/?email=$email'),
      body: jsonEncode({'email': email}));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

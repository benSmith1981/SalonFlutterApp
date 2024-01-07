import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add the http package
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart'; // Import the Fluttertoast package

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'Customer';

  final List<String> userTypes = ['Admin', 'Hairdresser', 'Customer'];

  Future<void> _register() async {
    final email = _emailController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    final userType = _selectedUserType;

    final url = Uri.parse(
        'https://salonflutterapp-0f5547cf61c1.herokuapp.com/register');

    // Create a Map to hold the registration data
    final Map<String, dynamic> registrationData = {
      'email': email,
      'username': username,
      'password': password,
      'userType': userType,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        }, // Set the content type to JSON
        body: json.encode(registrationData), // Encode data as JSON
      );

      if (response.statusCode == 200) {
        // Registration successful, handle the response here
        print('Registration Successful');
        // Display error message as a snack message
        Fluttertoast.showToast(
          msg: 'Registration Successful',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        // Registration failed, handle the error here
        print('Registration Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');

        // Display error message as a snack message
        Fluttertoast.showToast(
          msg: 'Registration Failed with status code: ${response.statusCode}',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      // Handle network or server errors here
      print('Error: $error');

      // Display error message as a snack message
      Fluttertoast.showToast(
        msg: 'Error: $error',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUserType = newValue!;
                });
              },
              items: userTypes.map((String userType) {
                return DropdownMenuItem<String>(
                  value: userType,
                  child: Text(userType),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'User Type',
              ),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

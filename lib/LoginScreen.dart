import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showMessage(String message) async {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void _login() async {
    String enteredUsername = _emailController.text;
    String enteredPassword = _passwordController.text;

    try {
      // Retrieve user document from Firestore based on entered username
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('Users')
          .where('userName', isEqualTo: enteredUsername)
          .get();

      // Check if a user with the entered username exists
      if (userQuery.docs.isNotEmpty) {
        // Get the first user document (assuming username is unique)
        var userDocument = userQuery.docs.first;

        // Retrieve user password hash from Firestore
        String userPasswordHash = userDocument['userPass'];
        int userType = userDocument['userType'];

        // Hash the entered password
        String hashedPassword =
            sha256.convert(utf8.encode(enteredPassword)).toString();

        // Compare hashed passwords
        if (userPasswordHash == hashedPassword && userType == 0) {
          _showMessage("Admin Login Successful!");
        }
        if (userPasswordHash == hashedPassword && userType == 1) {
          _showMessage("Customer Login Successful!");
        }
        if (userPasswordHash == hashedPassword && userType == 2) {
          _showMessage("Student Login Successful!");
        }
        if (userPasswordHash != hashedPassword) {
          _showMessage("Invalid username or password. Please try again.");
        }
      } else {
        _showMessage("Invalid username or password. Please try again.");
      }
    } catch (e) {
      _showMessage("Login failed. Error: $e");
    }
  }

  Future<void> _loginOLD() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final url =
        Uri.parse('https://salonflutterapp-0f5547cf61c1.herokuapp.com/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login successful, handle the response here
        print('Login Successful2');
        Navigator.pushNamed(context, '/homescreen');

        // You can navigate to another screen or show a toast message
        // or set a flag to indicate the user is logged in, etc.
        // For now, let's show a success toast message.
        Fluttertoast.showToast(
          msg: 'Login Successful',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // Login failed, handle the error here
        print('Login Failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // Display error message as a toast
        Fluttertoast.showToast(
          msg: 'Login Failed with status code: ${response.statusCode}',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      // Handle network or server errors here
      print('Error: $error');
      // Display error message as a toast
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
        title: Text('Login'),
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
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                // Navigate to the registration screen
                Navigator.pushNamed(context, '/register');
              },
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
    _passwordController.dispose();
    super.dispose();
  }
}

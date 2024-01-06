import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Add the http package

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

    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'username': username,
          'password': password,
          'userType': userType,
        },
      );

      if (response.statusCode == 200) {
        // Registration successful, handle the response here
        print('Registration Successful');
      } else {
        // Registration failed, handle the error here
        print('Registration Failed');
      }
    } catch (error) {
      // Handle network or server errors here
      print('Error: $error');
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

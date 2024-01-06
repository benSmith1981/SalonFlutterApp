import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class NewPage extends StatelessWidget {
  final String title;
  const NewPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Hello World'),
                SizedBox(width: 10),
                Icon(Icons.star, color: Colors.blue),
                Container(
                  child: Image.asset(
                    'images/IMG_2484.jpg',
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MySalonApp());
}

class MySalonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SalonHomePage(),
    );
  }
}

class SalonHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text("Salon Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .start, // Aligns children to the start, i.e., top of the column
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centers children horizontally
        children: <Widget>[
          Container(
            alignment: Alignment
                .topCenter, // Aligns the Container's child to the top center
            child: Row(
              // A Row is used inside the Container for horizontal layout
              mainAxisSize: MainAxisSize
                  .min, // Minimizes the row's width to its children's widths
              children: [
                Text('Hello World'),
                SizedBox(
                    width:
                        10), // Horizontal space between the text and the icon
                Icon(Icons.star, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('My Salon'),
  //     ),
  //     body: Center(
  //       child: Text(
  //         'Welcome to my Salon',
  //         style: TextStyle(
  //           fontSize: 24,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.pinkAccent,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

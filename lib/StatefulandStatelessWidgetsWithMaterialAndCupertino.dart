import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'statelesswidgetexample.dart';

void main() => runApp(MyApp());

//Cupertino IOS style app or Material app from google android
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use CupertinoApp for iOS
    // return CupertinoApp(
    //   title: 'Adaptive App',
    //   theme: CupertinoThemeData(
    //     primaryColor: CupertinoColors.activeBlue,
    //   ),
    //   home: MyHomePage(title: 'iOS Home Page'),
    // );

    // Use MaterialApp for Android (and other platforms)
    return MaterialApp(
      title: 'Adaptive App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Android Home Page'),
    );
  }
}

// This is an example of a stateful widget these are used when:

// Dynamic Content Update: If the content of MyHomePage needs to change dynamically
// (e.g., updating a counter, changing text based on user input).

// User Interactions: If you want to change the UI in response to user interactions
// like button presses, gestures, etc.

// Data Changes: If you need to rebuild the UI when data changes,
// such as fetching data from the internet or a database.
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, this.title = 'Default Title'}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//IOS Cupertino theme home page
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // A mutable state for tracking the counter

  void _incrementCounter() {
    setState(() {
      _counter++; // Increment the counter and call setState to rebuild the widget
    });
  }

//Cupertino themed scaffolding
  // @override
  // Widget build(BuildContext context) {
  //   return CupertinoPageScaffold(
  //     navigationBar: CupertinoNavigationBar(
  //       middle: Text(widget.title),
  //     ),
  //     child: SafeArea(
  //       // Wrap the body in a SafeArea for better layout
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: <Widget>[
  //           Text('You have pushed the button this many times:',
  //               style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
  //           Text('$_counter',
  //               style: CupertinoTheme.of(context)
  //                   .textTheme
  //                   .navTitleTextStyle), // Adjusted for Cupert
  //           CupertinoButton(
  //             onPressed: _incrementCounter,
  //             child: Text('Increment Counter'),
  //           ),
  //           CupertinoButton(
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 CupertinoPageRoute(
  //                     builder: (context) => NewPage(title: 'New Page Title')),
  //               );
  //             },
  //             child: Text('Go to New Page'),
  //           ),
  //           // Rest of your UI elements...
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //Android or Material theme homepage
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('You have pushed the button this many times:'),
          Text('$_counter', style: Theme.of(context).textTheme.headline4),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Counter'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewPage(title: 'New Page Title')),
              );
            },
            child: Text('Go to New Page'),
          ),
          // Rest of your UI elements...
        ],
      ),
    );
  }
}

//Material or google style scaffolding
class MyStatelessWidget extends StatelessWidget {
  final String title;

  MyStatelessWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Text(title),
    );
  }
}

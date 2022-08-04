import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    //This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notitication data in this method
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );
    // This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) { 
      print('firebaseMessage.onMessage');
      if(message.notification!=null){
        print('dungnd: ${message.notification!.title}');
        print('dungnd: ${message.notification!.body}');
        print('dungnd: ${message.data}');
      }
    });

    // this method only call when app in background and not terminated (not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) { 
      print('firebaseMessage.onMessageOpenedApp.listen');
      if(message.notification!=null){
        print(message.notification!.title);
        print(message.notification!.body);
        print('message data2${message.data['id']}');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

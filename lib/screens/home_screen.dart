import 'package:flutter/material.dart';
import 'package:todo_app/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqfLiteApp sqfLiteApp = SqfLiteApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('home screen')),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () async {
                int response = await sqfLiteApp
                    .insertData('''INSERT INTO tasks(title ,date ,time ,state )
                     VALUES("some task", "17/3", "0:1","ad")''');
                print('$response');
                print('database inserted');
              },
              color: Colors.red,
              textColor: Colors.white,
              child: Text('insertData'),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () async {
                List<Map> response =
                    await sqfLiteApp.getDatabase('SELECT * FROM tasks');
                print('$response');
                print('get database');
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('getData'),
            ),
          ],
        ),
      ),
    );
  }
}

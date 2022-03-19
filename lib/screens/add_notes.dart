import 'package:flutter/material.dart';
import 'package:todo_app/sqflite.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

SqfLiteApp sqfLiteApp = SqfLiteApp();
TextEditingController titleController = TextEditingController();
TextEditingController timeController = TextEditingController();
TextEditingController dataController = TextEditingController();
TextEditingController stateController = TextEditingController();

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddNotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'enter title'),
                ),
                TextFormField(
                  controller: dataController,
                  decoration: InputDecoration(hintText: 'enter date'),
                ),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(hintText: 'enter time'),
                ),
                TextFormField(
                  controller: stateController,
                  decoration: InputDecoration(hintText: 'enter state'),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  onPressed: () async {
                    int response = await sqfLiteApp.insertData(
                        '''INSERT INTO tasks('title', 'date', 'time' ,'state') 
                        VALUES("${titleController.text}","${dataController.text}","${timeController.text}","${stateController.text}")''');
                    print('response============================$response');
                    if (response > 0) {
                      Navigator.pop(context);
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('enter'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/sqflite.dart';

class UpdateScreen extends StatefulWidget {
  final title;
  late final time;
  late final date;
  late final state;
  late final id;

  UpdateScreen(
      {required this.title,
      required this.date,
      required this.state,
      required this.time,
      required this.id});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  SqfLiteApp sqfLiteApp = SqfLiteApp();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.title;
    timeController.text = widget.time;
    dataController.text = widget.date;
    stateController.text = widget.state;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateScreen'),
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
                    int response =
                        await sqfLiteApp.updateData('''UPDATE tasks SET
                    title= "${titleController.text}",
                    date="${dataController.text}",
                    time="${timeController.text}",
                    state="${stateController.text}"
                    WHERE id=${widget.id}
                    ''');
                    if (response > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false);
                    }
                    print('ooooooooooooooo');
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text('update'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

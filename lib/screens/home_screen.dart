import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/componants.dart';
import 'package:todo_app/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqfLiteApp sqfLiteApp = SqfLiteApp();

  Future<List<Map>> getDatabase() async {
    List<Map> response = await sqfLiteApp.getDatabase('SELECT * FROM tasks');
    return response;
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isButtonCheck = false;
  var textController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  IconData fabIcon = Icons.edit;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text('home screen')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isButtonCheck) {
            Navigator.pop(context);
            isButtonCheck = false;
            setState(() {
              fabIcon = Icons.add;
            });
          } else {
            scaffoldKey.currentState?.showBottomSheet(
              (context) => Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultTextForm(
                        controller: textController,
                        type: TextInputType.text,
                        label: 'Task Title',
                        icon: Icons.title,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                          controller: timeController,
                          type: TextInputType.number,
                          label: 'Task Time',
                          icon: Icons.watch_later_outlined,
                          onTap: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then((value) {
                              timeController.text =
                                  value!.format(context).toString();
                            });
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextForm(
                        controller: dateController,
                        type: TextInputType.datetime,
                        label: 'Task Date',
                        icon: Icons.accessibility_new_rounded,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2023-01-01'),
                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
            isButtonCheck = true;
            setState(() {
              fabIcon = Icons.edit;
            });
          }
        },
        child: Icon(fabIcon),
      ),
      body: Container(
        child: ListView(
          children: [
            FutureBuilder(
              future: getDatabase(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${snapshot.data![index]['title']}'),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

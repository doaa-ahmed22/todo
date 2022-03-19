import 'package:flutter/material.dart';
import 'package:todo_app/screens/update_screen.dart';

import 'package:todo_app/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqfLiteApp sqfLiteApp = SqfLiteApp();
  List data = [];
  bool isLoading = true;

  Future getDatabase() async {
    List<Map> response = await sqfLiteApp.getDatabase();
    data.addAll(response);
    isLoading = false;
    if (this.mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('home screen')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('Add Notes');
        },
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text('${data[index]['title']}'),
                          subtitle: Text('${data[index]['date']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int response = await sqfLiteApp.deleteData(
                                      'DELETE FROM tasks WHERE id = ${data[index]['id']}');
                                  if (response > 0) {
                                    data.removeWhere((element) =>
                                        element['id'] == data[index]['id']);
                                    setState(() {});
                                  }
                                  print('respoooooooonse=$response');
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UpdateScreen(
                                          title: data[index]['title'],
                                          date: data[index]['date'],
                                          state: data[index]['state'],
                                          time: data[index]['time'],
                                          id: data[index]['id']),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

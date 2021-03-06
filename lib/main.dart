import 'package:mariana_2018020181/TaskModel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mariana Simaremare',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Aplikasi Daftar Makanan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  List<TaskModel> tasks = [];

  TaskModel currentTask;

  final TodoHelper _todoHelper = TodoHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          TextField(
            controller: textController,
          ),
          FlatButton(
            child: Text("Tambah Menu Makanan"),
            onPressed: () {
              currentTask = TaskModel(makanan: textController.text);
              _todoHelper.insertTask(currentTask);
            },
            color: Colors.blue,
            textColor: Colors.white,
          ),
          FlatButton(
            child: Text("Daftar Menu"),
            onPressed: () async {
              List<TaskModel> list = await _todoHelper.getAllTask();

              setState(() {
                tasks = list;
              });
            },
            color: Colors.red,
            textColor: Colors.white,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text("${tasks[index].id}"),
                  title: Text("${tasks[index].makanan}"),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    ));
  }
}

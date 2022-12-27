import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
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
        iconTheme: IconThemeData(color: Colors.white, size: 18),
        cupertinoOverrideTheme: CupertinoThemeData(primaryColor: Colors.white),
      ),
      //home: const MyHomePage(title: 'Todo'),

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const MyHomePage(title: 'Todo'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/oldTasks': (context) => const oldTasksPage(title: 'Old tasks'),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

List<List> listTasks = [[Icon(Icons.favorite), "Task 1"]];
List<List> FinishedTasks = [];
List<List> DeletedTasks = [];

List<Icon> TaskIcons = [Icon(Icons.favorite, ), Icon(Icons.lock), Icon(Icons.schedule), Icon(Icons.event), Icon(Icons.paid), Icon(Icons.shopping_bag), Icon(Icons.lightbulb), Icon(Icons.report_problem), Icon(Icons.star_rate), Icon(Icons.build), Icon(Icons.work), Icon(Icons.today), Icon(Icons.watch_later), Icon(Icons.room), Icon(Icons.savings), Icon(Icons.pets), Icon(Icons.explore), Icon(Icons.bookmark), Icon(Icons.phone), Icon(Icons.alarm), Icon(Icons.airplanemode_active), Icon(Icons.fitness_center), Icon(Icons.house)];

class _MyHomePageState extends State<MyHomePage> {
  final taskInputController = TextEditingController();
  bool showAddTask = false;
  int selectedIcon = 0;

  void toggleCreateTask() {
    setState(() {
      showAddTask = !showAddTask;
      if(showAddTask) {
        hoverIcon = hoverIconRemove;
        hoverColor = hoverColorRemove;
      } else {
        hoverIcon = hoverIconAdd;
        hoverColor = hoverColorAdd;
      }
    });
  }

  Widget createTask(text, index) {
    return Container (
      color: const Color(-15198184),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 5),
                listTasks[index][0],
                SizedBox(width: 10),
                Expanded(
                  child: Text(listTasks[index][1], style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () => setState(() {
                      FinishedTasks.add([listTasks[index][0], listTasks[index][1]]);
                      Fluttertoast.showToast(
                          msg: "Completed: ${listTasks[index][1]}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      listTasks.removeAt(index);
                    }),
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 24.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () => setState(() {
                      DeletedTasks.add([listTasks[index][0], listTasks[index][1]]);
                      Fluttertoast.showToast(
                          msg: "Deleted: ${listTasks[index][1]}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      listTasks.removeAt(index);
                    }),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final double _kItemExtent = 32.0;
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          // The Bottom margin is provided to align the popup above the system navigation bar.
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          // Provide a background color for the popup.
          color: CupertinoColors.systemBackground.darkHighContrastColor,
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        ));
  }

  Icon hoverIconAdd = Icon(Icons.add);
  Color hoverColorAdd = Colors.blue;

  Icon hoverIconRemove = Icon(Icons.close);
  Color hoverColorRemove = Colors.red;

  Icon hoverIcon = Icon(Icons.add);
  Color hoverColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(-14606047),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/oldTasks');
                },
                child: Icon(
                  Icons.folder,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: Stack(
        children: [
          Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              const Text('Todo', style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 20),
              Expanded(child: ListView.builder(
                padding: EdgeInsets.all(12.0),
                itemExtent: 40.0,
                itemCount: listTasks.length,
                itemBuilder: (BuildContext ctxt, int index) => createTask(ctxt, index)
              )),
            ]
          ),
          if(showAddTask) ... [
            SizedBox.expand(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                ),
              ),
            ),
            Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  // Display a CupertinoPicker with list of fruits.
                  onPressed: () => _showDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: _kItemExtent,
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          selectedIcon = selectedItem;
                        });
                      },
                      children:
                      List<Widget>.generate(TaskIcons.length, (int index) {
                        return Center(
                          child: TaskIcons[index],
                        );
                      }),
                    ),
                  ),
                  // This displays the selected fruit name.
                  child: TaskIcons[selectedIcon],
                ),
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: taskInputController,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) => setState(() {
                      // Add to tasks
                      listTasks.add([TaskIcons[selectedIcon], value]);
                      toggleCreateTask();
                    }),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a task",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () => setState(() {
                      // Add to tasks
                      listTasks.add([TaskIcons[selectedIcon], taskInputController.text]);
                      toggleCreateTask();
                    }),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        onPressed: () {
          toggleCreateTask();
        },
        tooltip: 'Add task',
        backgroundColor: hoverColor,
        child: hoverIcon,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    taskInputController.dispose();
    super.dispose();
  }
}

class oldTasksPage extends StatefulWidget {
  const oldTasksPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<oldTasksPage> createState() => _oldTasksPageState();
}

class _oldTasksPageState extends State<oldTasksPage> {
  Widget createTask(text, index, list) {
    return Container (
      color: const Color(-15198184),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 5),
                list[index][0],
                SizedBox(width: 10),
                Text(list[index][1], style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    onPressed: () => setState(() {
                      Fluttertoast.showToast(
                          msg: "Restored: ${list[index][1]}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      listTasks.add([list[index][0], list[index][1]]);
                      list.removeAt(index);
                    }),
                    child: const Icon(
                      Icons.undo,
                      color: Colors.blue,
                      size: 24.0,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () => setState(() {
                      Fluttertoast.showToast(
                          msg: "Deleted: ${list[index][1]}",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      list.removeAt(index);
                    }),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 24.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: const Color(-14606047),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, size: 28),
          onPressed: () => setState(() {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ),
      ),
      body: Stack(
        children: [
          Column (
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 20),
                const Text('Finished tasks', style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 20),
                Expanded(child: ListView.builder(
                    padding: EdgeInsets.all(12.0),
                    itemExtent: 40.0,
                    itemCount: FinishedTasks.length,
                    itemBuilder: (BuildContext ctxt, int index) => createTask(ctxt, index, FinishedTasks)
                )),

                SizedBox(height: 20),
                const Text('Deleted tasks', style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                )),
                SizedBox(height: 20),
                Expanded(child: ListView.builder(
                    padding: EdgeInsets.all(12.0),
                    itemExtent: 40.0,
                    itemCount: DeletedTasks.length,
                    itemBuilder: (BuildContext ctxt, int index) => createTask(ctxt, index, DeletedTasks)
                )),
              ]
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }
}
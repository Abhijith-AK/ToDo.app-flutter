import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_base.dart';
import 'package:flutter_application_1/utils/todo_list.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  //reference hive box

  final _mybox = Hive.box('MyBox');

  final _task = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //1st time opening the app
    if(_mybox.isEmpty){
      db.initializeDatabase();
    }else{
      //data already exists
      db.loadData();
    }

    super.initState();
  }

  void checkBoxChanged(int index) {
    setState(() {
      db.listitems[index][1] = !db.listitems[index][1];
    });
    db.updateData();
  }

  void saveNewTask(){
    setState(() {
      db.listitems.add([_task.text, false]);
      _task.clear();
    });
    db.updateData();
  }

  void deleteExistingTask(int index){
    setState(() {
      db.listitems.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'To Do',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 95.0),
        child: ListView.builder(
          itemCount: db.listitems.length,
          itemBuilder: (BuildContext ctx, index) {
            return TodoList(
              taskName: db.listitems[index][0],
              taskCompleted: db.listitems[index][1],
              onChanged: (value) => checkBoxChanged(index),
              deleteFunction:(context) => deleteExistingTask(index),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _task,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple.shade200,
                  hintStyle: const TextStyle(color: Color.fromARGB(255, 10, 46, 88)),
                  hintText: "Add a new todo items ",
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            )),
            FloatingActionButton(
                foregroundColor: Colors.deepPurple,
                backgroundColor: Colors.white,
                onPressed: saveNewTask,
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}

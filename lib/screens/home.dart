import 'package:flutter/material.dart';

import 'package:flutter_todo_app_yt/constants/colors.dart';
import 'package:flutter_todo_app_yt/models/todo.dart';
import 'package:flutter_todo_app_yt/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = Todo.todoList();
  final todoController = TextEditingController();
  List<Todo> foundTodos = [];

  @override
  void initState() {
    foundTodos = todoList;
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              children: [
                SeachBox(onChangedText: _runFilter),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (Todo todo in foundTodos.reversed)
                        TodoItem(
                          todo: todo,
                          onTodoChaged: _handleTodoChange,
                          onTodoDelete: _deleteTodoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,

            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20.0,
                      left: 20.0,
                      right: 20.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, right: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _addNewTodo(todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(60.0, 60.0),
                      elevation: 10.0,
                      backgroundColor: tdBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('+', style: TextStyle(fontSize: 40.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addNewTodo(String todoText) {
    if (todoText.trim().isEmpty) {
      return;
    }
    setState(() {
      todoList.add(
        Todo(
          id: DateTime.now().microsecond.toString(),
          todoText: todoText.trim(),
        ),
      );
    });
    todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results =
          todoList
              .where(
                (item) => item.todoText!.toLowerCase().contains(
                  enteredKeyword.toLowerCase(),
                ),
              )
              .toList();
    }
    setState(() {
      foundTodos = results;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30.0),
          SizedBox(
            height: 40.0,
            width: 40.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset('assets/images/user_avatar.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}

class SeachBox extends StatelessWidget {
  const SeachBox({super.key, required this.onChangedText});

  final Function(String searchTerm) onChangedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        onChanged: (value) => onChangedText(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20.0),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20.0,
            minWidth: 25.0,
          ),
          border: InputBorder.none,
          hintText: 'Search...',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}

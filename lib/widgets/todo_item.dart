import 'package:flutter/material.dart';
import 'package:flutter_todo_app_yt/constants/colors.dart';
import 'package:flutter_todo_app_yt/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChaged,
    required this.onTodoDelete,
  });

  final Todo todo;
  final Function(Todo tod) onTodoChaged;
  final Function(String id) onTodoDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: () {
          onTodoChaged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16.0,
            color: tdBlack,
            decoration: todo.isDone! ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: IconButton(
            onPressed: () {
              onTodoDelete(todo.id!);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
            iconSize: 18.0,
          ),
        ),
      ),
    );
  }
}

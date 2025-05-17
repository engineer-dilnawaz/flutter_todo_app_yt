class Todo {
  String? id;
  String? todoText;
  bool? isDone;

  Todo({required this.id, required this.todoText, this.isDone = false});

  static List<Todo> todoList() {
    return [
      Todo(id: '1', todoText: 'Buy groceries', isDone: true),
      Todo(id: '2', todoText: 'Walk the dog'),
      Todo(id: '3', todoText: 'Do laundry'),
      Todo(id: '4', todoText: 'Finish Flutter project', isDone: true),
      Todo(id: '5', todoText: 'Read a book'),
      Todo(id: '6', todoText: 'Workout for 30 mins'),
      Todo(id: '7', todoText: 'Call mom'),
    ];
  }
}

class Todo {
  final int id;
  final String text;
  final bool isComplete;

  Todo({
    required this.id,
    required this.text,
    required this.isComplete,
  });

  Todo toggleComplete(){
    return Todo(
      id: id,
      text: text,
      isComplete: !isComplete,
    );
  }
}
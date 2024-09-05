import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]);

  // L O A D
  Future<void> loadTodo() async {
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  // A D D
  Future<void> addTodo(String text) async {
    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      text: text,
      isComplete: false,
    );
    await todoRepo.addTodo(newTodo);
    loadTodo();
  }

  // D E L E T E
  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);

    loadTodo();
  }

  // T O G G L E
  Future<void> toggleComplete(Todo todo) async {
    final updatedTodo = todo.toggleComplete();
    await todoRepo.updateTodo(updatedTodo);
    loadTodo();
  }
}

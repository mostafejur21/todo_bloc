import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/domain/models/todo.dart';
import 'package:todo_bloc/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Add Todo'),
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(hintText: 'Enter your todo'),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    todoCubit.addTodo(textController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final todo = state[index];
              return ListTile(
                title: Text(
                  todo.text,
                  style: TextStyle(
                    decoration: todo.isComplete ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
                subtitle: Text('id: ${todo.id}'),
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (_) {
                    context.read<TodoCubit>().toggleComplete(todo);
                  },
                ),
                trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<TodoCubit>().deleteTodo(todo);
                    }),
              );
            },
          );
        },
      ),
    );
  }
}

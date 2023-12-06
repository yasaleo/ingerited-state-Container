import 'package:flutter/material.dart';

import '../core/keys.dart';
import '../core/localization.dart';
import '../models.dart';
import '../state_container.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;

  const DetailScreen({
    required this.todo,
  }) : super(key: ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    print("building ====>> DetailScreen");
    final container = StateContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).todoDetails),
        actions: [
          IconButton(
            key: ArchSampleKeys.deleteTodoButton,
            icon: const Icon(Icons.delete),
            onPressed: () {
              container.removeTodo(todo);
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    key: ArchSampleKeys.detailsTodoItemCheckbox,
                    onChanged: (complete) {
                      container.updateTodo(todo, complete: !todo.complete);
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: ArchSampleKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: ArchSampleKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.labelMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editTodoFab,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddEditScreen(
                  todo: todo,
                  key: ArchSampleKeys.editTodoScreen,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

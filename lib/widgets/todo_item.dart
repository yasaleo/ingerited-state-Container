import 'package:flutter/material.dart';

import '../core/keys.dart';
import '../models.dart';

class TodoItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final ValueChanged<bool?>? onCheckboxChanged;
  final Todo todo;

  const TodoItem({
    super.key,
    required this.onDismissed,
    required this.onTap,
    this.onCheckboxChanged,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Dismissible(
          key: ArchSampleKeys.todoItem(todo.id),
          background: Container(
            color: Colors.red,
            child: const Icon(Icons.abc),
          ),
          onDismissed: onDismissed,
          child: ListTile(
            onTap: onTap,
            leading: Checkbox(
              key: ArchSampleKeys.todoItemCheckbox(todo.id),
              value: todo.complete,
              onChanged: onCheckboxChanged,
            ),
            title: Text(
              todo.task,
              key: ArchSampleKeys.todoItemTask(todo.id),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            subtitle: Text(
              todo.note,
              key: ArchSampleKeys.todoItemNote(todo.id),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}

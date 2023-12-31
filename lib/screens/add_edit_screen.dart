import 'dart:async';

import 'package:flutter/material.dart';

import '../core/keys.dart';
import '../core/localization.dart';
import '../models.dart';
import '../state_container.dart';


class AddEditScreen extends StatefulWidget {
  final Todo? todo;

  AddEditScreen({
     Key? key,
    this.todo,
  }) : super(key: key ?? ArchSampleKeys.addTodoScreen);
  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _task;
  String? _note;

  @override
  Widget build(BuildContext context) {
    final container = StateContainer.of(context);
    final localizations = ArchSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations.editTodo : localizations.addTodo,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          onWillPop: () {
            return Future(() => true);
          },
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo?.task : '',
                key: ArchSampleKeys.taskField,
                autofocus: !isEditing,
                style: Theme.of(context).textTheme.displayMedium,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint,
                ),
                validator: (val) {
                  return val!.trim().isEmpty
                      ? localizations.emptyTodoError
                      : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo?.note : '',
                key: ArchSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.titleMedium,
                decoration: InputDecoration(
                  hintText: localizations.notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? ArchSampleKeys.saveTodoFab : ArchSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();

            if (isEditing) {
              container.updateTodo(widget.todo!, task: _task, note: _note);
            } else {
              container.addTodo(Todo(
                _task??'',
                note: _note??'',
              ));
            }

            Navigator.pop(context);
          }
        },
      ),
    );
  }

  bool get isEditing => widget.todo != null;
}

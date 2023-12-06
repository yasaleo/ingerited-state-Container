import 'dart:async';
import 'dart:core';

import 'package:rxdart/rxdart.dart';

import '../../../todorepository.dart';
import '../reactive_repository.dart';


/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.
class ReactiveLocalStorageRepository implements ReactiveTodosRepository {
  final TodosRepository _repository;
  final BehaviorSubject<List<TodoEntity>> _subject;
  bool _loaded = false;

  ReactiveLocalStorageRepository({
    required TodosRepository repository,
    List<TodoEntity>? seedValue,
  })  : _repository = repository,
        _subject = seedValue != null
            ? BehaviorSubject<List<TodoEntity>>.seeded(seedValue)
            : BehaviorSubject<List<TodoEntity>>();

  @override
  Future<void> addNewTodo(TodoEntity todo) async {
    _subject.add([..._subject.value, todo]);

    await _repository.saveTodos(_subject.value);
  }

  @override
  Future<void> deleteTodo(List<String> idList) async {
    _subject.add(
      List<TodoEntity>.unmodifiable(_subject.value.fold<List<TodoEntity>>(
        <TodoEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _repository.saveTodos(_subject.value);
  }

  @override
  Stream<List<TodoEntity>> todos() {
    if (!_loaded) _loadTodos();

    return _subject.stream;
  }

  void _loadTodos() {
    _loaded = true;

    _repository.loadTodos().then((entities) {
      _subject.add(List<TodoEntity>.unmodifiable(
        [if (_subject.value != null) ..._subject.value, ...entities],
      ));
    });
  }

  @override
  Future<void> updateTodo(TodoEntity update) async {
    _subject.add(
      List<TodoEntity>.unmodifiable(_subject.value.fold<List<TodoEntity>>(
        <TodoEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _repository.saveTodos(_subject.value);
  }
}

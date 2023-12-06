import 'package:flutter/material.dart';
import 'package:inherited_state_container/state_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/key_value_storage/key_value_store_flutter.dart';
import 'core/todo_repo_local_storage/src/key_value_storage.dart';
import 'core/todo_repo_local_storage/src/repository.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(StateContainer(
    repository: LocalStorageRepository(
      localStorage: KeyValueStorage(
        'inherited_widget_todos',
        FlutterKeyValueStore(await SharedPreferences.getInstance()),
      ),
    ),
    child: const InheritedWidgetApp(),
  ));
}

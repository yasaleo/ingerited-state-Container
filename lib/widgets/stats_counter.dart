import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/keys.dart';
import '../core/localization.dart';
import '../state_container.dart';


class StatsCounter extends StatelessWidget {
  const StatsCounter() : super(key: ArchSampleKeys.statsCounter);

  @override
  Widget build(BuildContext context) {
    print("building ====>> StatsCounter");

    final container = StateContainer.of(context);
    final numCompleted = container.state.numCompleted;
    final numActive = container.state.numActive;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).completedTodos,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              '$numCompleted',
              key: ArchSampleKeys.statsNumCompleted,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).activeTodos,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text(
              '$numActive',
              key: ArchSampleKeys.statsNumActive,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          )
        ],
      ),
    );
  }
}

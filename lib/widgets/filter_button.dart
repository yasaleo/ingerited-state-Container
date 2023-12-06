import 'package:flutter/material.dart';

import '../core/keys.dart';
import '../core/localization.dart';
import '../models.dart';


class FilterButton extends StatelessWidget {
  final PopupMenuItemSelected<VisibilityFilter>? onSelected;
  final VisibilityFilter activeFilter;
  final bool isActive;

  const FilterButton({this.onSelected, this.activeFilter = VisibilityFilter.all, this.isActive = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.bodyMedium;
    final activeStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.primaryColor,
    );
    final button = _Button(
      onSelected: onSelected,
      activeFilter: activeFilter,
      activeStyle: activeStyle,
      defaultStyle: defaultStyle,
    );
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 150),
      child: isActive ? button : IgnorePointer(child: button),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
     this.onSelected,
    required this.activeFilter,
     this.activeStyle,
     this.defaultStyle,
  }) : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter>? onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle? activeStyle;
  final TextStyle? defaultStyle;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: ArchSampleKeys.filterButton,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem<VisibilityFilter>>[
          PopupMenuItem<VisibilityFilter>(
            key: ArchSampleKeys.allFilter,
            value: VisibilityFilter.all,
            child: Text(
              ArchSampleLocalizations.of(context).showAll,
              style: activeFilter == VisibilityFilter.all
                  ? activeStyle
                  : defaultStyle,
            ),
          ),
          PopupMenuItem<VisibilityFilter>(
            key: ArchSampleKeys.activeFilter,
            value: VisibilityFilter.active,
            child: Text(
              ArchSampleLocalizations.of(context).showActive,
              style: activeFilter == VisibilityFilter.active
                  ? activeStyle
                  : defaultStyle,
            ),
          ),
          PopupMenuItem<VisibilityFilter>(
            key: ArchSampleKeys.completedFilter,
            value: VisibilityFilter.completed,
            child: Text(
              ArchSampleLocalizations.of(context).showCompleted,
              style: activeFilter == VisibilityFilter.completed
                  ? activeStyle
                  : defaultStyle,
            ),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list),
    );
  }
}

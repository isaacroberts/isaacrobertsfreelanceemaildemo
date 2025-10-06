import 'dart:developer' as dev;

import 'package:flutter/material.dart';

import 'layout_constants.dart';

const List<String> weekdays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wendesday',
  'Thursday',
  'Friday',
  'Saturday',
];

class DateInfo extends StatelessWidget {
  final int index;
  const DateInfo({super.key, required this.index});

  String get date {
    if (index == 0) {
      return 'Just now';
    } else if (index == 1) {
      return 'Yesterday';
    }
    DateTime d = DateTime.now().add(Duration(days: -index));

    if (index < 7) {
      //Weekday names
      return weekdays[d.weekday % 7];
    }

    return "${d.month}/${d.day}/${d.year % 100}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      maxLines: 1,
      overflow: TextOverflow.visible,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

final DateTime built = DateTime.utc(2025, 10, 4, 12 + 5);

/// Bottom bar on email showing when emails were updated
/// Updated just now
/// Updates 10 minutes ago
class UpdatedWhen extends StatelessWidget {
  final Color color;
  const UpdatedWhen({super.key, required this.color});

  String durationToText(Duration duration) {
    int days = duration.inDays;
    if (days > 0) {
      if (days > 365) {
        int years = days ~/ 365;
        return '$years years ago';
      }
      return '$days days ago';
    }
    int hours = duration.inHours;
    if (hours > 0) {
      return '$hours hours ago';
    }
    int minutes = duration.inMinutes;
    if (minutes > 0) {
      return '$minutes minutes ago';
    }
    return 'just now';
  }

  @override
  Widget build(BuildContext context) {
    Duration diff = DateTime.now().difference(built);
    late final String text;
    try {
      text = durationToText(diff);
    } catch (exception, trace) {
      dev.log(exception.toString());
      dev.log(trace.toString());
      text = 'NEVER';
    }
    return Text(
      'Updated $text',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
    );
  }
}

///Purely for navigation
class MyBottomNavigation extends StatelessWidget {
  const MyBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'Inbox',
          icon: Icon(Icons.email_outlined),
        ),
        BottomNavigationBarItem(label: 'Menu', icon: Icon(Icons.menu)),
        BottomNavigationBarItem(
          label: 'Account',
          icon: Icon(Icons.account_circle),
        ),
      ],
    );
  }
}

///Slides up from the bottom
class EmailPageRoute extends PageRoute {
  final WidgetBuilder builder;
  EmailPageRoute({required this.builder});

  @override
  Color? get barrierColor => Color(0x80dddddd);

  @override
  String? get barrierLabel => 'Scrim';

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    Tween<Offset> offset = Tween<Offset>(begin: Offset(0, 1), end: Offset.zero);
    double width = MediaQuery.sizeOf(context).width;
    bool pad = width > minReaderWidth;
    return SlideTransition(
      key: Key('slide'),
      position: offset.animate(animation),
      //TODO: No pad if
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: pad ? 16 : 0),
        child: builder(context),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);
}

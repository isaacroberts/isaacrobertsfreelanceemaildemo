import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final bool isEnd;
  const MyDrawer({super.key, required this.isEnd});

  @override
  Widget build(BuildContext context) {
    String capLabel = isEnd ? 'End Drawer' : 'Drawer';

    List<Widget> children = [
      Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        child: Text(
          key: Key('drawerTitle'),
          capLabel,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      _DrawerMainContent(key: const Key('drawerCtt'), isEnd: isEnd),
      if (!isEnd) DrawerExampleNav(key: Key('drawerNav'), isEnd: isEnd),
      // Expanded(child: SizedBox.shrink()),
      //TODO: Slivers & Sliv
      //I want this to expand
    ];
    //Always display, even while scrolling
    // ];
    children.add(
      DrawerCopyrightContent(key: Key('copyrightContent'), isEnd: isEnd),
    );
    return NavigationDrawer(children: children);
  }
}

class _DrawerMainContent extends StatelessWidget {
  const _DrawerMainContent({super.key, required this.isEnd});

  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    String label = isEnd ? 'an end drawer' : 'a drawer';
    late List<Widget> children;

    if (!isEnd) {
      children = [
        // Divider(),
        Text(
          "This is a drawer. These should be the navigation items that your users are most likely to want or need. A more comprehensive navigation should be moved to its own page.",
        ),

        const SizedBox(height: 8),
        Text(
          "Since this demo app only has one page, these navigation tiles will close the drawer.",
        ),
        Divider(),
      ];
    } else {
      children = [
        Text(
          "This is an end drawer. Generally, you wouldn't have both. In this instance, I'm using the end drawer to hold settings, while the main drawer holds navigation.",
        ),
        const SizedBox(height: 8),
        Text(
          "//TODO: Add theme settings. It's relatively easy to change the theme in Flutter, including dark/light mode. In stage one, we'll just build one, because dark/light mode still requires some custom components, even with Flutter's theme setup.",
        ),
      ];
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: isEnd
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

///Opens drawer, but looks like email back button
///There's no back to go to, of course, so it opens the drawer
class MyDrawerButton extends StatelessWidget {
  const MyDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      alignment: Alignment.center,
      icon: Icon(Icons.arrow_back_ios),
    );
  }
}

class DrawerExampleNav extends StatelessWidget {
  final bool isEnd;
  const DrawerExampleNav({super.key, required this.isEnd});

  void closeDrawers(BuildContext context) {
    var scaffoldState = Scaffold.of(context);
    //Do both because we've added two drawers to be cheeky
    scaffoldState.closeDrawer();
    scaffoldState.closeEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      listTile(context, 'Home'),
      listTile(context, 'Shop'),
      listTile(context, 'Info'),
      listTile(context, 'Bookings'),
      listTile(context, 'Schedule'),
    ];

    if (!isEnd) {
      children.addAll(<Widget>[
        smallListTile(context, 'About'),
        smallListTile(context, 'Certifications'),
        smallListTile(context, 'Licenses'),
        smallListTile(context, 'Disclosures'),
      ]);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: children,
    );
  }

  ListTile listTile(BuildContext context, String item) =>
      ListTile(title: Text(item), onTap: () => closeDrawers(context));

  ListTile smallListTile(BuildContext context, String item) =>
      ListTile(title: Text(item, style: Theme.of(context).textTheme.bodySmall));
}

/// Copyright Isaac Roberts 2025
/// Open Sorcery LLC
class DrawerCopyrightContent extends StatelessWidget {
  final bool isEnd;
  const DrawerCopyrightContent({super.key, required this.isEnd});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle? style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.secondaryContainer,
    );
    //Must be manually matched to DrawerTheme
    const double bottomLeftRadius = 14;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onSecondaryContainer,
        border: Border.all(color: theme.colorScheme.secondary, width: 1),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: isEnd ? Radius.circular(bottomLeftRadius) : Radius.zero,
        //   bottomRight: isEnd ? Radius.zero : Radius.circular(bottomLeftRadius),
        // ),
      ),
      //MAX WIDTH
      width: 20000,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Copyright Open Sorcery LLC', style: style),
          Text("Developed by Isaac Roberts", style: style),
          Text("Code is for demonstration purposes only.", style: style),
        ],
      ),
    );
  }
}

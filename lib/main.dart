import 'package:app_launch_demo/components.dart';
import 'package:app_launch_demo/email_body.dart';
import 'package:app_launch_demo/sidebar.dart';
import 'package:app_launch_demo/theme.dart';
import 'package:app_launch_demo/timings.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';
import 'layout_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Isaac Roberts App Dev',
      theme: theme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //TODO: If the width is less than the index reveal width,
      //Show my face as the leading icon
      appBar: AppBar(
        leading: MyDrawerButton(key: Key('myDrawerButton')),
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text("ColdEmail.ly"),
        centerTitle: true,
      ),
      body: EmailLayout(key: Key('emlLayout')),

      drawer: MyDrawer(key: const Key('drawer'), isEnd: false),
      endDrawer: MyDrawer(key: const Key('drawer'), isEnd: true),
      // bottomSheet: MyBottomSheet(key: Key('btmSheet')),
      bottomNavigationBar: const MyBottomNavigation(key: Key('btmNav')),
      extendBody: false,
      extendBodyBehindAppBar: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Get started',
        child: const Icon(Icons.edit),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onContact() {
    openLink('mailto:isaaclevinroberts@gmail.com', context);
  }
}

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: "Scroll to top",
          child: IconButton(
            onPressed: onScrollUp,
            icon: Icon(
              Icons.vertical_align_top_sharp,
              color: colorScheme.onSurface,
              size: 16,
            ),
          ),
        ),
        UpdatedWhen(color: colorScheme.onSurface),
        Tooltip(
          message:
              'This button is only here for visual symmetry. In a real app, I would find a purpose for this button.',
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: colorScheme.onSurface,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  void onScrollUp() {
    scrollUpCommand.sendCommand();
  }
}

class EmailLayout extends StatelessWidget {
  const EmailLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // return builder(
    //   context,
    //   BoxConstraints(
    //     minHeight: 10,
    //     minWidth: 10,
    //     maxHeight: MediaQuery.sizeOf(context).height,
    //     maxWidth: MediaQuery.sizeOf(context).width,
    //   ),
    // );
    return LayoutBuilder(builder: builder);
  }

  Widget builder(BuildContext context, BoxConstraints constraints) {
    if (constraints.maxWidth < minReaderWidth) {
      return EmailBody(key: Key('body'));
    } else if (constraints.maxWidth < minReaderWidth + sideWidth) {
      return Row(
        children: [
          SizedBox(
            width: sideWidth,
            child: Sidebar(key: Key('sidebar')),
          ),
          Expanded(child: EmailBody(key: Key('body'))),
        ],
      );
    } else {
      return Row(
        children: [
          SizedBox(
            width: sideWidth,
            child: Sidebar(key: Key('sidebar')),
          ),
          Expanded(child: EmailBody(key: Key('body'))),
        ],
      );
    }
  }
}

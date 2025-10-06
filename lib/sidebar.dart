import 'package:app_launch_demo/timings.dart';
import 'package:flutter/material.dart';

//
class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<StatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        image: DecorationImage(
          image: AssetImage('assets/redwoods.jpg'),
          opacity: .7,
          fit: BoxFit.cover,
        ),
      ),

      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              """Isaac Roberts""",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          TextButton(
            onPressed: copyPhone,
            child: Text(
              "(843) 607-0382",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
          TextButton(
            onPressed: copyEmail,
            child: Text(
              "isaaclevinroberts@gmail.com",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  void copyPhone() {
    copyText(context, '(843) 607-0382');
  }

  void copyEmail() {
    copyText(context, 'isaaclevinroberts@gmail.com');
  }
}

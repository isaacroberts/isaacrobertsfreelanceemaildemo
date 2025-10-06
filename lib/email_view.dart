import 'package:app_launch_demo/tile.dart';
import 'package:flutter/material.dart';

import 'email_copy.dart';

class EmailView extends StatefulWidget {
  final Email email;
  const EmailView({super.key, required this.email});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  @override
  void initState() {
    email.markAsRead();
    super.initState();
  }

  Email get email => widget.email;
  @override
  Widget build(BuildContext context) {
    /*
    Scaffold(
      key: Key('scaf'),
      bottomNavigationBar: const MyBottomNavigation(key: Key('btmNav')),
      // appBar: AppBarFlexibleSpaceBar(title: Text(email.subject), centerTitle: true, collapseMode: CollapseMode.pin,),
      //TODO: Apple has it so this hides when the subject line is visible
      //TODO: Once that's done, change it to the subject line
      appBar: AppBar(centerTitle: true, title: Text(email.subject)),
      // backgroundColor: Color(0x00ffffff),
      body:
     */
    return Padding(
      padding: EdgeInsets.only(top: 32),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 8, right: 8),
          child: SingleChildScrollView(
            key: Key('readerSV'),
            child: Center(
              key: Key('c'),
              child: SizedBox(
                key: Key('s'),
                width: 800,
                child: Column(
                  key: Key('col'),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //Same as preview tile, but without message preview
                    EmailTile(
                      key: Key('topTile'),
                      email: email,
                      showMessage: false,
                    ),
                    Padding(
                      key: Key('titlePad'),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: Text(
                        key: Key('text'),
                        email.subject,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Padding(
                      key: Key('p'),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        key: Key('body'),
                        email.message,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        key: Key('signoff'),
                        email.signoff,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 8 * 8),
                    FilledButton(onPressed: onClose, child: Text('Close')),
                    const SizedBox(height: 8 * 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onClose() {
    Navigator.pop(context);
  }
}

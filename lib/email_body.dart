import 'package:app_launch_demo/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'email_copy.dart';

class SimpleCommander extends ChangeNotifier {
  void sendCommand() {
    notifyListeners();
  }
}

SimpleCommander scrollUpCommand = SimpleCommander();

///List of emails & scrollview
class EmailBody extends StatefulWidget {
  const EmailBody({super.key});

  @override
  State<EmailBody> createState() => _EmailBodyState();
}

class _EmailBodyState extends State<EmailBody> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollUpCommand.addListener(scrollUp);
  }

  @override
  void dispose() {
    scrollUpCommand.removeListener(scrollUp);
    super.dispose();
  }

  void scrollUp() {
    controller.animateTo(
      0,
      duration: Duration(seconds: 3),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(controller: controller, itemBuilder: itemBuilder);
  }

  Widget itemBuilder(BuildContext context, int index) {
    List<Email> cachedEmails = List.generate(250, getEmail);

    //
    index = index % cachedEmails.length;
    return EmailTile(
      key: Key('email$index'),
      email: cachedEmails[index],
      showMessage: true,
    );
  }
}

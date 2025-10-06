import 'package:app_launch_demo/theme.dart';
// import 'package:flutter/cupertino.dart' as cuper;
import 'package:flutter/material.dart';

import 'components.dart';
import 'email_copy.dart';
import 'email_view.dart';

///Used for both ListView and top of email reader
class EmailTile extends StatefulWidget {
  final Email email;

  ///True for listView and false for reader
  final bool showMessage;
  const EmailTile({
    required super.key,
    required this.email,
    required this.showMessage,
  });

  @override
  State<EmailTile> createState() => _EmailTileState();
}

class _EmailTileState extends State<EmailTile> {
  Email get email => widget.email;
  int get index => widget.email.index;
  String get subject => widget.email.subject;
  String get sender => widget.email.from;
  String get message => widget.email.message;
  bool get showMessage => widget.showMessage;

  Widget subjectRow(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    late final String dispMessage;
    if (showMessage) {
      dispMessage = message.replaceAll('\n', ' ');
    } else {
      dispMessage = '';
    }
    bool bold = email.type.isMyAd && !email.read;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SubjectAndDate(
          key: Key('subjAndDate'),
          sender: sender,
          textTheme: textTheme,
          index: index,
        ),
        Text(
          subject,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        if (widget.showMessage)
          Text(
            dispMessage,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
      ],
    );
  }

  Widget content(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconAndRead(key: Key('iconAndReadBell'), email: email),
        // EmailIcon(email: widget.email),
        SizedBox(width: 8),
        Expanded(child: subjectRow(context)),
      ],
    );
  }

  Widget emailViewBuilder(BuildContext context) {
    return EmailView(email: widget.email);
  }

  void onTap() {
    Navigator.of(context).push(EmailPageRoute(builder: emailViewBuilder));
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: email.readValueNotifier,
      builder: builder,
    );
  }

  Widget builder(BuildContext context, Widget? previous) {
    Widget child = InkWell(
      onTap: showMessage ? onTap : null,

      // email.read ?
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: content(context),
      ),
    );
    if (email.special) {
      child = DecoratedBox(
        decoration: BoxDecoration(
          border: email.read ? null : Border.all(color: isaacPrimary),
          gradient: LinearGradient(
            colors: [
              email.read ? Color(0xfff1f5ff) : Color(0xffffffff),
              email.read ? Color(0xffa8b6f3) : Color(0xff6e7dbc),
            ],
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
          ),
        ),

        child: child,
      );
    }
    return child;
  }
}

class _SubjectAndDate extends StatelessWidget {
  const _SubjectAndDate({
    required super.key,
    required this.sender,
    required this.textTheme,
    required this.index,
  });

  final String sender;
  final TextTheme textTheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Expanded, so that when size is less, the subject shrinks before date
        Expanded(
          child: Text(
            sender,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(width: 56, child: DateInfo(index: index)),
      ],
    );
  }
}

class EmailIcon extends StatelessWidget {
  final Email email;
  const EmailIcon({super.key, required this.email});
  String get sender => email.from;

  @override
  Widget build(BuildContext context) {
    bool special = email.type == EmailType.mine;
    return Tooltip(
      message: '$sender (${email.type.displayType})',
      child: Container(
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          gradient: special
              ? LinearGradient(
                  colors: [Color(0xff6a7af4), Color(0xff1b74bd)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          borderRadius: BorderRadius.circular(8),
          color: email.type.getColor(),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(email.type.getIcon(), size: 24, color: Colors.white),
      ),
    );
  }
}

class IconAndRead extends StatelessWidget {
  final Email email;
  const IconAndRead({required super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: email.readValueNotifier,
      builder: builder,
    );
  }

  Widget builder(BuildContext context, Widget? child) {
    if (email.read) {
      return EmailIcon(email: email);
    } else {
      late final Color notifColor;
      if (email.special) {
        //Enough blue already on these
        notifColor = isaacPrimary;
      } else if (email.type.isMyAd) {
        //Standard notif blue
        notifColor = Color(0xff566ed1);
        // notifColor = Color(0xff0088ff);
      } else {
        //We don't actually want to draw users attention to these
        notifColor = Color(0xff888888);
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmailIcon(email: email),
          SizedBox(height: 8),
          Icon(Icons.circle, size: 16, color: notifColor),
        ],
      );
    }
  }
}

String sentenceCase(String s) {
  return s.substring(0, 1).toUpperCase() + s.substring(1);
}

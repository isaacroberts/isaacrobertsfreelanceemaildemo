import 'package:flutter/material.dart';

enum EmailType {
  //my advertisement
  mine,
  //
  friend,
  //Hiring scam
  scam,
  //Other business
  businessAd,
  //Other
  business,
  //
  approveLogin,
  //actblue
  charity,
  //err
  none;

  bool get isMyAd {
    switch (this) {
      case EmailType.mine:
      case EmailType.friend:
      case EmailType.businessAd:
      //Include none because I wnat to see them
      case EmailType.none:
        return true;
      case EmailType.scam:
      case EmailType.business:
      case EmailType.approveLogin:
      case EmailType.charity:
        return false;
    }
  }

  String get signoff {
    switch (this) {
      case EmailType.mine:
        return "Sincerely,";
      case EmailType.friend:
        return '';
      case EmailType.scam:
      case EmailType.business:
      case EmailType.businessAd:
      case EmailType.charity:
        return 'Sincerely,';
      case EmailType.approveLogin:
        return "This message was sent by an automated system.";
      case EmailType.none:
        return 'Oops,';
    }
  }

  String get displayType {
    switch (this) {
      case EmailType.mine:
        return 'Dev';
      case EmailType.friend:
        return "Contact";
      case EmailType.scam:
        return 'Scam likely';
      case EmailType.businessAd:
        return 'Business';
      case EmailType.business:
        return 'Business (Automated)';
      case EmailType.charity:
        return '501-C3';
      case EmailType.approveLogin:
        return 'Account alert';
      case EmailType.none:
        return "Unknown";
    }
  }

  IconData getIcon() {
    switch (this) {
      case EmailType.mine:
        return Icons.email_outlined;
      case EmailType.friend:
        return Icons.account_circle;
      case EmailType.scam:
        return Icons.group_off;
      case EmailType.businessAd:
        return Icons.business;
      case EmailType.business:
        return Icons.business;
      case EmailType.charity:
        return Icons.handshake;
      case EmailType.approveLogin:
        return Icons.crisis_alert_outlined;
      case EmailType.none:
        return Icons.error_outline;
    }
  }

  Color getColor() {
    switch (this) {
      case EmailType.mine:
        return Color(0xff3349ed);
      case EmailType.friend:
        return Color(0xff24c13f);
      case EmailType.scam:
        return Color(0xff9c81b3);
      case EmailType.businessAd:
      case EmailType.business:
      case EmailType.charity:
        return Color(0xff7c81b6);
      case EmailType.approveLogin:
        return Color(0xffb67c8b);
      case EmailType.none:
        return Color(0xffe67815);
    }
  }
}

///Stores data for email
class Email {
  static int currentIndex = 0;
  final String from;
  final String subject;
  final String message;
  final int index;
  final EmailType type;
  ValueNotifier<bool> readValueNotifier = ValueNotifier(false);
  bool get read => readValueNotifier.value;

  void markAsRead() {
    readValueNotifier.value = true;
  }

  Email({
    required this.index,
    required this.from,
    required this.subject,
    required this.message,
    required this.type,
  });

  Email.gmail({required this.index})
    : from = 'Google',
      type = EmailType.approveLogin,
      subject = 'Critical Alert: Somebody logged in to your Gmail.',
      message =
          "This is not a drill. Think back. Do you remember logging in to your Gmail account on ${DateTime.timestamp().toString()}?\n\nLook me in the eyes. There's no reason to lie. Was this you logging into your account?";

  Email.err({required this.index})
    : from = 'Null',
      subject = "Don't believe him",
      message =
          "This app has bugs. For example, this email should only show up when an error is caught in the email generation function. Frankly, there's no excuse for him showing you this.",
      type = EmailType.none;

  bool get special => type == EmailType.mine;

  String get signoff {
    if (type == EmailType.friend) {
      //Only first name from friends
      return from.split(' ').firstOrNull ?? from;
    }
    return '${type.signoff}\n$from';
  }
}

String getSender(int index) {
  index = index % emailFroms.length;
  return emailFroms[index];
}

Email getEmail(final int index) {
  // if (index % 5 == 3) {
  //   return Email.scam(index: index, scamAttempt: index ~/ 5);
  // }

  if (index % 4 == 3) {
    return Email.gmail(index: index);
  }

  _Message message = _exampleMessages[index % _exampleMessages.length];
  String sender = message.sender ?? getSender(index);
  if (message.type == EmailType.mine) {
    sender = 'Isaac Roberts';
  }
  return Email(
    type: message.type,
    index: index,
    subject: message.subject,
    message: message.message,
    //Some messages have senders included, some don't
    from: sender,
  );
}

class _Message {
  final String? sender;
  final String subject;
  final String message;
  final EmailType type;
  const _Message(this.type, this.subject, this.message, {this.sender});
}

/// Subject, Message, Sender(?)
/// If sender is included, it will replace the default name
const List<_Message> _exampleMessages = [
  _Message(
    EmailType.mine,
    'App ASAP',
    "Get your app ASAP! Isaac Roberts mobile app development can build your app fast, getting you to market in time to make money! Business isn't about doing it right the first time, business is about doing it at all!\n\nOnce you've made 5 digits, come back for the next level. Isaac can build high-quality apps, so you won't have to start over once your business matures.\n\nIsaac Roberts has been building hobby apps for 10 years, and has specialized in getting an idea working quickly. Over this time, Isaac has found that requirements change, and as they do, the carefully laid foundations can become obsolete. Building an MVP (Minimum Viable Product) allows you to know what your requirements really are.",
  ),
  _Message(
    EmailType.businessAd,
    "Scale!!!",
    """Here's a secret. Engineering-wise, it's better to build for the future, from day one. But, business-wise, it's better to sell products fast. Your engineers will complain when they have to tear up legacy code, but by then you'll have the money to afford complexity.
    
 It's a new way of looking at business. Each expense is seen as an investment - one that needs to make 6% per year to beat an index fund. If you spent all your money on bells & whistles up front, you're losing 6% of the value of those features every year. 
 
That's why in my podcast, 'Masters of Scale', I advocated for building software only once you need it - and only building the parts that you need. You may be tempted to build GDPR compliance, copyright compliance, EU compliance, accessibility, screen-readers, translations, and HIPAA compliance from day one. But if you do, you'll be losing 6% per year on the development time - or worse, you'll go bankrupt.  
 
 My dear friend Mark Zuckerberg says: "Move fast and break things." I assume if you were a welder, or a nurse, or a museum curator, this would be bad advice. And my dear friend Mark has broken several things. But, in the world of startups, that's how the game works.
 """,
    sender: 'Reid Hoffman, CEO and Investor at Facebook',
  ),
  _Message(
    EmailType.mine,
    'One Dev for all quality levels',
    "Changing developers halfway through a project usually means starting over. Lone developers don't comment their code, and firms aren't willing to share it.\n\nIsaac Roberts has the technical skill to build an MVP app fast, and the meticulousness to turn it into a high quality app. That means you can go from mad-dash MVP to mature, polished app without renegotiating contracts.",
  ),
  _Message(
    EmailType.charity,
    'We need your help more than ever',
    "Yourname - Trump is beating our ass 8 ways till Sunday. He's deadnaming representatives. He's throwing Hitler salutes. He's standing outside the library with a lit cocktail. We're cooked if we don't act now!!\n\nLook. AOC's in a rough spot. Congressional paychecks don't come until Friday. Can you rush a 14\$ donation to get her a Jimmy John's?",
    sender: 'ActBlue',
  ),
  _Message(
    EmailType.friend,
    'Book finished!',
    "Good news! Isaac Roberts finally finished his book, and now he's ready to start making software again! For personal reasons, Isaac is only opening his services to small businesses.\n\nIsaac has been coding for 14 years, and writing mobile & web apps for 3 years. The book itself was put online using Flutter.",
  ),
  _Message(
    EmailType.mine,
    'MVP = Minimum Viable Product',
    "MVPs are a well-established technique in software development. Minimum Viable Products allow you to use the tool, allowing you to better understand how you use it, and what features you need.\n\nSometimes, the addition of a new feature can wreck your carefully laid infrastructure. I found that out the hard way, when I spent 2 weeks laying out a templated presets system, only to have to change it every project.\n\nIn Silicone Valley, MVPs are used to impress investors & raise seed capital. If you don't live in Silicone Valley, you'll be using your MVP to make money, by selling goods & services to customers. ",
  ),
  _Message(
    EmailType.business,
    'Registered Agent Service Invoice',
    "YourName LLC,\n\nYour Registered Agent service invoice from Tennessee Registered Agent LLC has been created and is due by 12/15/2026. This provides you Registered Agent services through 12/15/2026.\n\nIt costs 150\$ and 20 minutes to set up an LLC, or 225\$ and 20 minutes if you go through a service.\n\nYou could use a Registered Agent to hide your home address, though. That's 50\$ per month, and includes a business phone number.",
    sender: 'Registered Agent',
  ),
  _Message(
    EmailType.friend,
    "Where to get app developers?",
    "Google: Where to get mobile & web developers, please?\nGoogle: Please show me full stack frontend and backend developers.\nGoogle: Please find a developer capable of making a UI and server code.\nGoogle: Thank you for the help. I need to build a cribbage assistant.",
    sender: 'Grandpa',
  ),

  _Message(
    EmailType.mine,
    'Flutter is an excellent framework',
    "The service that I am offering would not be possible without the Flutter framework. The Flutter framework was built by Google to help Android steal market share from Apple, and they had the time, professionalism, and management support to do a really good job.\n\nGoogle has some really smart people, and they did a really good job with it. Customization is built into the design philosophy. The components work under every circumstance. Null safety is genius and intuitive.\n\nIn 3 years of using Flutter, I've never seen it get \"haunted\" like most frameworks do. I once had a client who made me use the Kivvy Python framework. Kivvy couldn't register a single button click on Linux, flickered nonstop, and had its own paradigm for button callbacks. I begged the client to let me use a different framework, and he got insulted and stopped working with me. I assume his father invented the it.\n\nWhen I was working in JUCE, for music production, I spent a week trying to figure out why melodies were playing at double speeds. Finally, I discovered that FLStudio used its own (incorrect) time signatures, storing 4/4 time as 4/16. I then had to guess and check until I figured out what idiomatic math the FLStudio developer made up.\n\nThere is no such nonsense in Flutter. Google has the utmost professionalism, care, and attention to detail. On our projects, we will use the Flutter framework, and we will have 95% less bugs because of it.",
  ),
  _Message(
    EmailType.friend,
    "I'm about to rob a bank!!!",
    "Big companies want 50,000\$ just to start! I know that my app could make that once it's built, but I need the revenue first!!!\n\nWho set up this system??? If our country really loves small business owners, why don't they offer grants? I went to a bank for a small business loan, and they called me a hick for not living in California!\n\n If you know of a way I could get an app built for a tenth of that, that would really help.",
  ),
  // _Message(
  //   EmailType.friend,
  //   "Will they let me skip the extras?",
  //   "I went to a development firm, and they said I had to pay for GDPR compliance. I don't even know what that is!\n\nThis feels like Big Government busting my business! I'm a small business owner! Those rules were meant for large business owners!\n\nLook, I just need an app where my customers can tell me where to show up, and what with! I have 4 different sets of tools, and I need to know which one I'm bringing to the job site. Is that so wrong, if it doesn't have a cookie popup? What is a cookie?",
  // ),
];

const List<String> emailFroms = [
  'Robert Jackson',
  'Trishia James',
  'Jeff Marquis',
  'Reba McIntyre',
  'Rochelle James',
  'Lock De Roche',
  'Sammy Kunitz-Levy',
  'Harold Johnson',
  'Josh Denver',
  'Donnie Belogi',
];

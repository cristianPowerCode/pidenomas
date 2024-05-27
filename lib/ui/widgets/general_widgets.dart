import 'package:flutter/material.dart';
import '../general/colors.dart';
import '../general/type_messages.dart';

SizedBox divider12() => const SizedBox(height: 12.0);

SizedBox divider20() => const SizedBox(height: 20.0);

SizedBox divider30() => const SizedBox(height: 30.0);

SizedBox divider40() => const SizedBox(height: 40.0);

void snackBarMessage(BuildContext context, Typemessage typemessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: messageColor[typemessage],
      content: Row(
        children: [
          Icon(messageIcon[typemessage], color: Colors.white),
          SizedBox(width: 8.0),
          Expanded(child: Text(message[typemessage]!))
        ],
      ),
      duration: Duration(seconds: 2),
    ),
  );
}
void snackBarMessage2(BuildContext context, Typemessage typemessage, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: messageColor[typemessage],
      content: Row(
        children: [
          Icon(messageIcon[typemessage], color: Colors.white),
          SizedBox(width: 8.0),
          Expanded(child: Text(message))
        ],
      ),
      duration: Duration(seconds: 2),
    ),
  );
}

class PrincipalText extends StatelessWidget {
  String string;

  PrincipalText({
    required this.string,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      style: TextStyle(
        color: kBrandPrimaryColor1,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      string,
    );
  }
}

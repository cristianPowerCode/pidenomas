import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pidenomas/ui/general/colors.dart';

class CheckBox2Widget extends StatefulWidget {
  final Function(bool) onChanged;

  CheckBox2Widget({
    required this.onChanged,
  });

  @override
  State<CheckBox2Widget> createState() => _CheckBox2WidgetState();
}

class _CheckBox2WidgetState extends State<CheckBox2Widget> {
  bool agreeTerms = false;
  bool isChanged = false;

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(
                activeColor: kBrandPrimaryColor1,
                value: agreeTerms,
                onChanged: (bool? value) {
                  setState(() {
                    isChanged = true;
                    agreeTerms = value!;
                    widget.onChanged(value);
                  });
                },
              ),
            ),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text:
                          'Yo acepto recibir notificaciones de ofertas y noticias',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

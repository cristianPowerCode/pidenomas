import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pidenomas/ui/general/colors.dart';

class CheckBox1Widget extends StatefulWidget {
  final Function(bool) onChanged;
  final String error;

  CheckBox1Widget({required this.onChanged, required this.error});

  @override
  State<CheckBox1Widget> createState() => _CheckBox1WidgetState();
}

class _CheckBox1WidgetState extends State<CheckBox1Widget> {
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
                text: TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Yo acepto los ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'términos de uso',
                      style: TextStyle(
                        color: kBrandPrimaryColor1,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL('https://www.ejemplo.com/terminos-de-uso');
                        },
                    ),
                    TextSpan(
                      text: ', ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'términos de servicio',
                      style: TextStyle(
                        color: kBrandPrimaryColor1,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL('https://www.ejemplo.com/terminos-de-servicio');
                        },
                    ),
                    TextSpan(
                      text: ' y ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'políticas de privacidad',
                      style: TextStyle(
                        color: kBrandPrimaryColor1,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL('https://www.ejemplo.com/politicas-de-privacidad');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 42.0),
          child: Text(
            widget.error.isNotEmpty ? ' *${widget.error}' : '',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

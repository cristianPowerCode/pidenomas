import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';
import 'package:pidenomas/ui/widgets/general_widgets.dart';

class ChatNegocioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  divider20(),
                  Text(
                    "Detalle de Reparto",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kBrandSecundaryColor1,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(
                      color:
                          kBrandSecundaryColor1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(
                      color:
                          kBrandSecundaryColor1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    borderSide: BorderSide(
                      color:
                          kBrandSecundaryColor1,
                    ),
                  ),
                  hintText: 'Enter a search term',
                  suffixIcon: Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

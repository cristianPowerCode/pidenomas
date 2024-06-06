import 'package:flutter/material.dart';
import 'package:pidenomas/ui/general/colors.dart';

class GridTypeOfHousingWidget extends StatefulWidget
{
  @override
  State<GridTypeOfHousingWidget> createState() =>
      _GridTypeOfHousingWidgetState();

  final Map<IconData, String> options;
  final Function(int) onSelected;

  GridTypeOfHousingWidget({
    required this.options,
    required this.onSelected,
  });
}

class _GridTypeOfHousingWidgetState extends State<GridTypeOfHousingWidget> {
  int selectedIndex = 0;
  IconData selectedIcon = Icons.question_mark;

  // void _onContainerTapped(String text, IconData icon) {
  //   setState(() {
  //     selectedText = text;
  //     selectedIcon = icon;
  //   });
  //   widget.onSelected(text);
  //   print('Texto seleccionado: $text');
  //   print('Icono seleccionado: ${icon.codePoint}');
  // }

  void _handleSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
      selectedIcon = widget.options.keys.toList()[index - 1];
      print(selectedIndex);
    });
    widget.onSelected(index); // Llamar a onSelected aquí
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.options.entries.toList().asMap().entries.map((entry) {
          int index = entry.key + 1; // +1 para empezar desde 1
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              _handleSelectedIndex(index);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 0, right: 10.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7.0),
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: isSelected ? kBrandPrimaryColor1 : Colors.grey,
                  ),
                ),
                padding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(entry.value.key,
                        size: 30.0,
                        color:
                        isSelected ? kBrandPrimaryColor1 : Colors.grey),
                    SizedBox(height: 5),
                    Text(
                      entry.value.value,
                      style: TextStyle(
                          color: isSelected
                              ? kBrandPrimaryColor1
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
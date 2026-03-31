import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyMacroWidget extends StatelessWidget {
  const MyMacroWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.value});

  final String title;
  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow:  [
            BoxShadow(color: Colors.grey.shade400, offset: const Offset(2, 2), blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FaIcon(
              icon,
              color: Colors.redAccent,
            ),
            const SizedBox(height: 4,),
            Text(
              title == 'Cal.' ? '$value $title' : '${value}g $title',
              style: const TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    ));
  }
}

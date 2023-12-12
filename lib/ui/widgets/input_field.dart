import 'package:final_project_mobile/ui/theme.dart';
import 'package:flutter/material.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
              height: 52,
              color: Colors.grey,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0))),
        ],
      ),
    );
  }
}

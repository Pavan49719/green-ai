import 'package:flutter/material.dart';

class answer extends StatefulWidget {
  const answer({Key? key}) : super(key: key);

  @override
  State<answer> createState() => _answerState();
}

class _answerState extends State<answer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        "Hello, We have given your answer. Ask nexgt question",
        style: const TextStyle(
            fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

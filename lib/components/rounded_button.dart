import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
   const RoundedButton({Key? key, required this.title, required this.colour, required this.onPressed}) : super(key: key);

  final String title;
  final Color colour;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: double.infinity,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }
}
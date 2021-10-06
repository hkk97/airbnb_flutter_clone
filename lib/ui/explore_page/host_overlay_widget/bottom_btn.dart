import 'package:flutter/material.dart';

class BottomBtn extends StatelessWidget {
  final Function onTap;
  final bool isJoinded;
  final Color color;
  const BottomBtn({
    Key? key,
    required this.color,
    required this.onTap,
    required this.isJoinded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.redAccent,
          child: Center(
            child: Text(
              isJoinded ? "Let's go!" : 'Try Hosting',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      height: 75,
    );
  }
}

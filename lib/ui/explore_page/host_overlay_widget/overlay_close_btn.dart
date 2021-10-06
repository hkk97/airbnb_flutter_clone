import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverlayCloseBtn extends StatelessWidget {
  final Function onTap;

  const OverlayCloseBtn({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await onTap();
      },
      child: Container(
        height: 30,
        width: 30,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 3.5, horizontal: 3.5),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AnimatedScaleWidget extends AnimatedWidget {
  final String title;
  final Function onTap;

  const AnimatedScaleWidget({
    Key? key,
    controller,
    required this.title,
    required this.onTap,
  }) : super(key: key, listenable: controller);

  Animation<double> get controller => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: controller.value * 50,
        ),
        child: SizedBox(
          height: 60,
          child: Card(
            color: Colors.redAccent,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TryHostDisplayWidget extends StatelessWidget {
  const TryHostDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Try Hosting on",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Text("Airbnb",
                style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Join us. We'll help you every",
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            Text(
              "step of the way",
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}

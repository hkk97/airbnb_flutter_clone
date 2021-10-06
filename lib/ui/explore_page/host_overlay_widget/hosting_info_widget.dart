import 'package:flutter/material.dart';

class HostingInofoWidget extends StatelessWidget {
  const HostingInofoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Hosting",
              style: TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "makes Airbnb,",
              style: TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Airbnb",
              style: TextStyle(
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              'You can host',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'anything, anywhere',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

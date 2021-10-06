import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExporeHostingWidget extends StatelessWidget {
  final Function onTap;
  const ExporeHostingWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Column(
                children: const [
                  Text(
                    'Explore what hosting',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    'can do for you',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                await onTap();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: 55,
                    width: 165,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 25.0),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          'Start earning',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

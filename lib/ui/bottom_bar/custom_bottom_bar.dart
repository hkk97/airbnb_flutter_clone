import 'package:airbandb/ui/bottom_bar/model/bottom_bar_item.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int index;
  final Function(int) selectedIndex;

  const CustomBottomBar(
      {Key? key, required this.index, required this.selectedIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        currentIndex: index,
        onTap: (index) => selectedIndex(index),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
        ),
        showUnselectedLabels: true,
        items: BottomBarItem.items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, right: 5.0, bottom: 3.0),
                  child: SizedBox(
                    width: 35,
                    height: 25,
                    child: Image(
                      image: AssetImage(
                        item.assetImage,
                      ),
                      color: index == BottomBarItem.items.indexOf(item)
                          ? Colors.red
                          : Colors.grey,
                    ),
                  ),
                ),
                label: item.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

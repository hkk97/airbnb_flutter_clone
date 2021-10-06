import 'package:airbandb/ui/explore_page/animated_fade_widget.dart';
import 'package:airbandb/ui/explore_page/hosting_carousel_view.dart';
import 'package:airbandb/ui/explore_page/model/host_anywhere_model.dart';
import 'package:flutter/material.dart';

class AnyHostExampleWidget extends StatelessWidget {
  final ValueNotifier<int> anyHost;
  const AnyHostExampleWidget({
    Key? key,
    required this.anyHost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.95,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              HostingCarouselController(
                listOfItem: HostAnyWhereModel.items,
                onPageChanged: (value) {
                  anyHost.value = value;
                },
              ),
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: anyHost,
                  builder: (context, value, child) {
                    return AnimatedFadeWidget(
                      key: UniqueKey(),
                      model: HostAnyWhereModel.items[value],
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

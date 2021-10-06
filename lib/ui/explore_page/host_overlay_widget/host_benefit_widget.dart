import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HostBenefitWidget extends StatelessWidget {
  const HostBenefitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "We'll help you bring",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "the art of hosting to life",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Column(
              children: [
                SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: const Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/try_host/help/support_host.webp'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Text(
                        'Learn how we support Hosts',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Center(
                    child: Container(
                      color: Colors.grey,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: const Image(
                            fit: BoxFit.fill,
                            image: AssetImage(
                                'assets/try_host/help/host_experience.webp'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Text(
                        'Host your experience',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

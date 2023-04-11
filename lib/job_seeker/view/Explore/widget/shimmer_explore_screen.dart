import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constraints/constraints.dart';

// ignore: must_be_immutable
class ShimmerExploreScreen extends StatelessWidget {
  ShimmerExploreScreen({super.key, required this.icons});

  Icon icons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 78, 78, 78),
            highlightColor: Colors.grey,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Column(
                        children: const [
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.bookmark)
                    ]),
              ),
            )),
        kHeight(10),
        Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 78, 78, 78),
            highlightColor: Colors.grey,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Column(
                        children: const [
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.bookmark)
                    ]),
              ),
            )),
        kHeight(10),
        Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 78, 78, 78),
            highlightColor: Colors.grey,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Column(
                        children: const [
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          )
                        ],
                      ),
                      const Icon(Icons.bookmark)
                    ]),
              ),
            )),
        kHeight(10),
        Shimmer.fromColors(
            baseColor: const Color.fromARGB(255, 78, 78, 78),
            highlightColor: Colors.grey,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Card(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                        ),
                      ),
                      Column(
                        children: const [
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          ),
                          Card(
                            child: SizedBox(
                              height: 18,
                              width: 200,
                            ),
                          )
                        ],
                      ),
                      icons
                    ]),
              ),
            )),
      ],
    );
  }
}

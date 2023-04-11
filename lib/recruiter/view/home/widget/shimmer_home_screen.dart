import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRecruiterPage extends StatelessWidget {
  const ShimmerRecruiterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 51, 51, 51),
      highlightColor: const Color.fromARGB(255, 125, 125, 125),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color.fromARGB(255, 94, 94, 94))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Card(
                  child: SizedBox(
                    width: 100.0,
                    child: Shimmer.fromColors(
                      baseColor: Colors.black12,
                      highlightColor: Colors.grey,
                      child: const SizedBox(
                        height: 100,
                        width: 39,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: [
                      Card(
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.grey,
                          child: const SizedBox(
                            width: 200.0,
                            height: 20.0,
                          ),
                        ),
                      ),
                      Card(
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.grey,
                          child: const SizedBox(
                            width: 200.0,
                            height: 17.0,
                          ),
                        ),
                      ),
                      Card(
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.grey,
                          child: const SizedBox(
                            width: 200.0,
                            height: 15.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

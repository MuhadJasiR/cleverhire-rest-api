import 'package:flutter/cupertino.dart';

import '../core/constraints/constraints.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("CleverHire", style: kMainFont),
        Text(
          "Connecting Top Talent With Best Employers",
          style: kSubFont,
        )
      ],
    );
  }
}

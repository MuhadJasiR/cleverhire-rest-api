import 'package:cleverhire/core/color/color.dart';
import 'package:cleverhire/recruiter/controller/provider/get_applied_people_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SeekerDetails extends StatelessWidget {
  SeekerDetails({super.key, required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Consumer<GetAppliedPeoplesProvider>(
        builder: (context, value, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Name : ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  value.appliedPeoples![index].appliedBy.username,
                  style: const TextStyle(color: kMainColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Email : ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  value.appliedPeoples![index].appliedBy.email,
                  style: const TextStyle(color: kMainColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date of birth : ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${value.appliedPeoples![index].profile[0].dateOfBirth.day}-${value.appliedPeoples![index].profile[0].dateOfBirth.month}-${value.appliedPeoples![index].profile[0].dateOfBirth.year}",
                  style: const TextStyle(color: kMainColor),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Address : ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  value.appliedPeoples![index].profile[0].address,
                  // value.appliedPeoples![index].profile[index].address,
                  style: const TextStyle(color: kMainColor),
                )
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text(
            //       "Occupation : ",
            //       style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            //     ),
            //     Text("Flutter developer")
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

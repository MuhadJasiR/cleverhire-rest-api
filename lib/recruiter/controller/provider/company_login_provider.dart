import 'dart:developer';

import 'package:cleverhire/recruiter/controller/api_services/company_login_services.dart';
import 'package:cleverhire/recruiter/model/company_login_req_model/company_req_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CompanyLoginProvider with ChangeNotifier {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isLoading = false;
  String? selectedDate;

  Future companyLogin() async {
    isLoading = true;
    final companyName = companyNameController.text.trim();
    final companyEmail = emailController.text.trim();

    final country = countryController.text.trim();
    final address = addressController.text.trim();

    final companyRecruiter = CompanyReqModel(
        companyName: companyName,
        establishedDate: selectedDate!,
        companyEmail: companyEmail,
        country: country,
        address: address);
    CompanyLoginApiService().companyLoginVerification(companyRecruiter);
  }

  void datePick(context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      if (kDebugMode) {
        print(pickedDate);
      }
    }

    selectedDate = DateFormat("yyyy-MM-dd").format(pickedDate!);
    log(selectedDate.toString());
    notifyListeners();
  }
}

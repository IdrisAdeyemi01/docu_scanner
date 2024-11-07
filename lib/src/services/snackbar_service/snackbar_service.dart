import 'package:docu_scanner/src/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  /// A method to show a [SnackBar] for successful activity
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.green,
        content: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  /// A method to show a [SnackBar] for successful activity
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(
    String text,
  ) {
    return scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: AppColors.red,
        content: Text(
          text,
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}

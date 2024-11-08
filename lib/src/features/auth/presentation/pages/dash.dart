import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/bottom_sheet_menu.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const Column(
        children: [
          SizedBox(height: AppConstants.defaultPadding),
          Text('Welcome to the Dashboard'),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.dashboardTitle),
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            BottomSheetMenuWidget.show(
              context: context,
              buttons: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Logout
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout), 
                        SizedBox(width: AppConstants.defaultPadding), 
                        Text(AppStrings.dashboardLogoutButtonText), 
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class BottomSheetMenuWidget {
  static void show({required BuildContext context, required List<Widget> buttons}) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buttons
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';

class CommentsCard extends StatelessWidget {
  final String title;
  final String content;
  final String username;

  const CommentsCard({ 
    super.key, 
    required this.title, 
    required this.content, 
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: AppConstants.primaryColor.withAlpha(30),
        onTap: () {
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: AppConstants.defaultPadding, top: AppConstants.defaultPadding), // Adjust the value as needed
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.person_outline_rounded),
                    const SizedBox(width: AppConstants.defaultPadding),
                    Text(username.substring((username.length/2).round())),
                  ],
                ),
              ),  
              ListTile(
              title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              subtitle: Text(
                content,
              ),
            ),
            ],
          ),
      ),
      );
  }
}
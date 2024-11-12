import 'package:flutter/material.dart';
import 'package:flutter_take_home/src/core/constants/app_strings.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';

class PostCard extends StatelessWidget {
  final String title;
  final String content;
  final String commentCount;
  final int postId;

  const PostCard({ 
    super.key, 
    required this.title, 
    required this.content, 
    required this.commentCount,
    required this.postId
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: AppConstants.primaryColor.withAlpha(30),
        onTap: () {
          if (postId != -1) {
            context.go('${AppStrings.postDetailsRoute}/$postId');
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              ListTile(
              title: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: postId == -1 ? 10 : 1,
                overflow: TextOverflow.ellipsis
                ),
              subtitle: Text(
                content,
                maxLines: postId == -1 ? 500 : 3,
                overflow: TextOverflow.ellipsis
              ),
            ),
            if (postId != -1)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        context.go('${AppStrings.postDetailsRoute}/$postId');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.chat_outlined, color: AppConstants.gradientEnd), 
                          const SizedBox(width: AppConstants.defaultPadding), 
                          Text(commentCount), 
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_take_home/src/core/constants/app_constants.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/blocs/details_bloc/details_bloc.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../widgets/comments_card.dart';
import '../widgets/post_card.dart';

class PostDetailsPage extends StatefulWidget {
  final String postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  PostDetailsPageState createState() => PostDetailsPageState();
}

class PostDetailsPageState extends State<PostDetailsPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(context).add(FetchCommentsEvent(int.parse(widget.postId)));
    BlocProvider.of<PostBloc>(context).add(FetchPostEvent(int.parse(widget.postId)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: pageBody(),
    );
  }

  BlocProvider<PostsBloc> pageBody() {
    return BlocProvider(
      create: (context) => GetIt.instance<PostsBloc>(),
      child: Column(
        children: [
          const SizedBox(height: AppConstants.defaultPadding),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostLoading) {
                return const Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppConstants.gradientEnd),
                ));
              } else if (state is PostFailure) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is PostSuccess) {
                final post = state.post;
                return PostCard(
                  title: post.title, 
                  content: post.body, 
                  commentCount: '-1', 
                  postId: -1,
                );
              } else {
                return const Center(child: Text(AppStrings.noPostsAvailable));
              }
            },
          ),
          const Text(
            AppStrings.postDetailsCommentsTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, state) {
                if (state is DetailsLoading) {
                  return const Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppConstants.gradientEnd),
                  ));
                } else if (state is DetailsFailure) {
                  return Center(
                    child: Text(state.error),
                  );
                } else if (state is DetailsSuccess) {
                  return ListView.builder(
                    itemCount: state.comments.length,
                    itemBuilder: (context, index) {
                      final comment = state.comments[index];
                      return CommentsCard(
                        title: comment.name,
                        content: comment.body,
                        username: comment.name
                      );
                    },
                  );
                } else {
                  return const Center(child: Text(AppStrings.postDetailsNoComments));
                }
              },
            ),
          ),
        ],
      ),
    );
  }


  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.postDetailsTitle),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: 
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.go(AppStrings.dashboardRoute);
          },
        ),
    );
  }
}

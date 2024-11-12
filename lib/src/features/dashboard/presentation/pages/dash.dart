import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_take_home/src/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/bottom_sheet_menu.dart';
import '../../../../core/widgets/post_card.dart';
import '../blocs/details_bloc/details_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostsBloc>(context).add(FetchPostsEvent(10, 1));
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: appBar(context),
    body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLogoutSuccess) {
          context.go(AppStrings.loginRoute);
        } else if (state is AuthLogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppConstants.gradientEnd),
            ));
          } else if (state is PostsFailure) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is PostsSuccess) {
            final posts = state.posts;
            for (var post in posts) {
              context.read<DetailsBloc>().add(FetchCommentsEvent(post.id));
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return BlocBuilder<DetailsBloc, DetailsState>(
                  builder: (context, commentsState) {
                    String commentCountText = AppStrings.commentCountPlaceholder;
                    if (commentsState is DetailsSuccess) {
                      commentCountText = commentsState.comments.length.toString();
                    } else if (commentsState is DetailsFailure) {
                      commentCountText = AppStrings.commentCountFailure;
                    }
                    return PostCard(
                      title: post.title,
                      content: post.body,
                      commentCount: commentCountText,
                      postId: post.id,
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text(AppStrings.noPostsAvailable));
          }
        },
      ),
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
                      BlocProvider.of<AuthBloc>(context)
                          .add(AuthLogoutButtonPressed());
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.logout, color: Colors.black,),
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

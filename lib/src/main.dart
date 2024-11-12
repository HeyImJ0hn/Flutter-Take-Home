import 'package:flutter/material.dart';
import 'package:flutter_take_home/src/features/dashboard/data/datasources/dash_data_source.dart';
import 'package:flutter_take_home/src/features/dashboard/domain/repositories/api_repository.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/blocs/details_bloc/details_bloc.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/blocs/post_bloc/post_bloc.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/pages/dash.dart';
import 'package:flutter_take_home/src/features/dashboard/presentation/pages/post_details.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_take_home/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_take_home/src/features/auth/presentation/pages/login.dart';
import 'package:flutter_take_home/src/core/constants/app_constants.dart';
import 'package:go_router/go_router.dart';

import 'core/constants/app_strings.dart';
import 'features/auth/data/datasources/auth_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/is_authenticated_use_case.dart';
import 'features/auth/domain/usecases/login_use_case.dart';
import 'features/auth/domain/usecases/logout_use_case.dart';
import 'features/dashboard/data/repositories/dash_repository_impl.dart';
import 'features/dashboard/domain/usecases/fetch_comments_use_case.dart';
import 'features/dashboard/domain/usecases/fetch_post_use_case.dart';
import 'features/dashboard/domain/usecases/fetch_posts_use_case.dart';
import 'features/dashboard/presentation/blocs/posts_bloc/posts_bloc.dart';

void main() {
  setup();
  runApp(const MyApp());
}

void setup() {
  GetIt.instance
      .registerLazySingleton<AuthDataSource>(() => AuthDataSourceImpl());
  GetIt.instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(GetIt.instance()));
  GetIt.instance
      .registerLazySingleton<DashDataSource>(() => DashDataSourceImpl());
  GetIt.instance.registerLazySingleton<DashRepository>(
      () => DashRepositoryImpl(GetIt.instance()));

  GetIt.instance.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(GetIt.instance()));
  GetIt.instance.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(GetIt.instance()));
  GetIt.instance.registerLazySingleton<IsAuthenticatedUseCase>(
      () => IsAuthenticatedUseCase(GetIt.instance()));

  GetIt.instance.registerLazySingleton<AuthBloc>(() => AuthBloc(
        GetIt.instance<LoginUseCase>(),
        GetIt.instance<LogoutUseCase>(),
        GetIt.instance<IsAuthenticatedUseCase>(),
      ));

  GetIt.instance.registerLazySingleton<FetchCommentsUseCase>(
      () => FetchCommentsUseCase(GetIt.instance()));
  GetIt.instance.registerLazySingleton<FetchPostUseCase>(
      () => FetchPostUseCase(GetIt.instance()));
  GetIt.instance.registerLazySingleton<FetchPostsUseCase>(
      () => FetchPostsUseCase(GetIt.instance()));

  GetIt.instance.registerLazySingleton<PostsBloc>(() => PostsBloc(
        GetIt.instance<FetchPostsUseCase>(),
      ));

  GetIt.instance.registerLazySingleton<DetailsBloc>(() => DetailsBloc(
        GetIt.instance<FetchCommentsUseCase>(),
      ));

  GetIt.instance.registerLazySingleton<PostBloc>(() => PostBloc(
        GetIt.instance<FetchPostUseCase>(),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.instance<AuthBloc>(),
        ),
        BlocProvider<PostsBloc>(
          create: (context) => GetIt.instance<PostsBloc>(),
        ),
        BlocProvider<DetailsBloc>(
          create: (context) => GetIt.instance<DetailsBloc>(),
        ),
        BlocProvider<PostBloc>(
          create: (context) => GetIt.instance<PostBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: themeData(),
        routerConfig: _router,
      ),
    );
  }

  ThemeData themeData() {
    return ThemeData(
      primarySwatch: Colors.orange,
      scaffoldBackgroundColor: AppConstants.backgroundColor,
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppConstants.gradientEnd,
        selectionColor: AppConstants.gradientEnd,
        selectionHandleColor: AppConstants.gradientEnd,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: AppConstants.gradientEnd),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.black),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              WidgetStateProperty.all(AppConstants.buttonForeground),
        ),
      ),
      cardTheme: const CardTheme(
        color: Colors.white,
        elevation: 2.0,
        margin: EdgeInsets.all(AppConstants.defaultPadding),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstants.backgroundColor,
        surfaceTintColor: Colors.black,
        elevation: 2.0,
        iconTheme: IconThemeData(color: AppConstants.gradientEnd),
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: AppStrings.loginRoute,
  routes: [
    GoRoute(
      path: AppStrings.loginRoute,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: AppStrings.dashboardRoute,
      builder: (context, state) {
        return const DashboardPage();
      },
    ),
    GoRoute(
      path: '${AppStrings.postDetailsRoute}:${AppStrings.postDetailsRouteParam}',
      builder: (context, state) {
        final postId = state.pathParameters[AppStrings.postDetailsRouteParam]!;
        return PostDetailsPage(postId: postId);
      },
    )
  ],
);

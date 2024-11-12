import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_take_home/src/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../core/widgets/gradient_elevated_button.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(CheckAuthenticationStatus());
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.go(AppStrings.dashboardRoute);
        } else if (state is AuthFailure) {
          if (state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(AppConstants.defaultPaddingLarge),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    middleContent(context),
                    bottomContent(context),
                  ],
                ),
                if (state is AuthLoading)
                  Positioned.fill(
                    child: Container(
                      color: AppConstants.backgroundColor.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppConstants.gradientEnd),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    ),
  );
}


  Expanded middleContent(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.loginTitle,
              style: AppConstants.titleStyle,
            ),
            const Text(
              AppStrings.loginSubtitle,
              style: AppConstants.subtitleStyle,
            ),
            const SizedBox(height: AppConstants.defaultPaddingExtraLarge),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: AppStrings.loginUsername,
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.loginFormEmptyField;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: AppStrings.loginPassword,
                prefixIcon: Icon(Icons.lock_outline_rounded),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.loginFormEmptyField;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.defaultPadding),
          ],
        ),
      ),
    );
  }

  Column bottomContent(BuildContext context) {
    return Column(
      children: [
        GradientElevatedButton(
          width: double.infinity,
          height: AppConstants.buttonHeight,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          onPressed: () {
            FocusScope.of(context).unfocus();
            if (!_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.loginValidationFail)),
              );
            } else {
              BlocProvider.of<AuthBloc>(context).add(AuthLoginButtonPressed(
                  username: _usernameController.text,
                  password: _passwordController.text));
            }
          },
          child: const Text(AppStrings.loginButtonText),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

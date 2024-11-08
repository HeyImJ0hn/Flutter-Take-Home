import 'package:flutter/material.dart';
import 'package:flutter_take_home/src/core/constants/app_constants.dart';
import 'package:flutter_take_home/src/core/widgets/gradient_elevated_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppConstants.defaultPaddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            middleContent(),

            bottomContent(),
          ],
        ),
      ),
    );
  }

  Expanded middleContent() {
    return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome,',
                  style: AppConstants.titleStyle,
                ),
                const Text(
                  'Please login to continue',
                  style: AppConstants.subtitleStyle,
                ),

                const SizedBox(height: AppConstants.defaultPaddingExtraLarge),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(height: AppConstants.defaultPadding),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                ),
                
                const SizedBox(height: AppConstants.defaultPadding),
              ],
            ),
          );
  }

  Column bottomContent() {
    return Column(
          children: [
            GradientElevatedButton(
                    width: double.infinity,
                    height: AppConstants.buttonHeight,
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                    onPressed: () {},
                    child: const Text('Login'),
                  ),
          ],
        );
  }
}

import 'package:break_time/providers/auth_provider.dart';
import 'package:break_time/services/onboarding_services.dart';
import 'package:break_time/utiles/colors.dart';
import 'package:break_time/utiles/constants.dart';
import 'package:break_time/widget/button.dart';
import 'package:break_time/widget/checkbox.dart';
import 'package:break_time/widget/custom_text.dart';
import 'package:break_time/widget/custom_textfield.dart';
import 'package:break_time/widget/reusable_widget.dart';
import 'package:break_time/widget/size_box.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isSelected = false;
  bool isLogin = true;

  bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _continueBtn(AuthenticationProvider authProvider) async {
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();

    if (email.isEmpty) {
      showToast("Please enter an email id");
    } else if (!isValidEmail(email)) {
      showToast("Please enter a valid email id");
    } else if (password.isEmpty) {
      showToast("Please enter a password");
    } else if (password.length < 6) {
      showToast("Password must be at least 6 characters");
    } else {
      if (isLogin) {
        await authProvider.login(email, password);
      } else {
        await authProvider.signUp(email, password);
      }
      if (authProvider.user != null) {
        bool isOnboardingCompleted = await OnboardingService()
            .hasCompletedOnboarding(authProvider.user!.uid);
        if (isOnboardingCompleted) {
          Navigator.pushReplacementNamed(context, Constants.homeRoute);
        } else {
          Navigator.pushReplacementNamed(context, Constants.onboardingRoute);
        }
      } else {
        showToast(authProvider.errorMessage ?? "Authentication failed");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthenticationProvider>(context, listen: false)
          .checkUserState()
          .then((_) {
        if (mounted && authProvider.user != null) {
          OnboardingService()
              .hasCompletedOnboarding(authProvider.user!.uid)
              .then((completed) {
            if (mounted) {
              Navigator.pushReplacementNamed(
                context,
                completed ? Constants.homeRoute : Constants.onboardingRoute,
              );
            }
          });
        }
      });
    });
  }

  AuthenticationProvider get authProvider =>
      Provider.of<AuthenticationProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      backgroundColor: AppColor.backgroundColors,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Height(80),
                sectionHeader(isLogin ? 'Login to continue' : 'Sign Up to continue', size: 17.00),
                const Height(20),
                customTextField(
                  controller: _emailController,
                  hintText: 'Enter your email id',
                ),
                const Height(15),
                customTextField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: 'Enter your password',
                ),
                const Height(15),
                CheckBox(
                  text: "I have a referral code (optional)",
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      isSelected = value!;
                    });
                  },
                ),
                const Height(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: isLogin
                          ? "Don't have an account?"
                          : "Already have an account?",
                      color: const Color(0xFF525871),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: CustomText(
                        text: isLogin ? "Sign Up" : "Login",
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "By clicking, I accept the ",
                      letterSpacing: -0.26,
                      color: const Color(0xFF525871),
                    ),
                    CustomText(
                      text: "Terms of Use",
                      letterSpacing: -0.26,
                      decoration: TextDecoration.underline,
                      color: const Color(0xFF525871),
                    ),
                    CustomText(
                      text: "  &  ",
                      letterSpacing: -0.26,
                      color: const Color(0xFF525871),
                    ),
                    CustomText(
                      text: "Privacy Policy",
                      letterSpacing: -0.26,
                      decoration: TextDecoration.underline,
                      color: const Color(0xFF525871),
                    ),
                  ],
                ),
                const Height(15),
                ContinueButton(
                  text: isLogin ? 'Login' : 'Sign Up',
                  isValid: true,
                  isLoading: authProvider.isLoading,
                  onTap: () => _continueBtn(authProvider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

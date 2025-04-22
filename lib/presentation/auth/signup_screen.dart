import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/logic/auth/auth_state_cubit.dart';
import 'package:mini_taskhub/presentation/dashboard/dashboard_screen.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/utils/utils.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_filed.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool isChecked = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void _handleSignUp() {
    FocusScope.of(context).unfocus();

    if (formKey.currentState!.validate()) {
      if (!isChecked) {
        Utils.showSnackBar(
          context,
          'Please agree to the terms and conditions',
          isError: true,
        );
        return;
      }
      getIt<AuthCubit>().signUp(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? _validateConfirmPassord(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthStateCubit>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          Utils.showSnackBar(context, state.error.toString(), isError: true);
        }
        if (state.status == AuthStatus.authenticated) {
          getIt<AppRouter>().pushAndRemoveUntil(const DashboardScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xFF212832),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 10, right: 18, left: 18),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(text: 'Mini '),
                              TextSpan(
                                text: 'TaskHub',
                                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create an account',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Email Address",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        CustomTextFiled(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email',
                          obscureText: false,
                          validator: _validateEmail,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Password",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        CustomTextFiled(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          obscureText: obscureText,
                          validator: _validatePassword,
                          prefixIcon: Icon(
                            Icons.lock_open_rounded,
                            color: Colors.white,
                          ),
                          suffixIcon: InkWell(
                            onTap: _toggleObscureText,
                            child: Icon(
                              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          "Confirm Password",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        CustomTextFiled(
                          controller: confirmPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Confirm Password',
                          obscureText: true,
                          validator: _validateConfirmPassord,
                          prefixIcon: Icon(
                            Icons.lock_open_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isChecked,
                              checkColor: Theme.of(context).colorScheme.primary,
                              autofocus: true,
                              fillColor: WidgetStateProperty.all(Colors.transparent),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value ?? false;
                                });
                              },
                            ),
                            Text(
                              'I agree to the terms and conditions',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomButton(
                          onPressed: _handleSignUp,
                          text: 'Sign Up',
                        ),
                        SizedBox(height: size.height * 0.02),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.8,
                                endIndent: 10,
                              ),
                            ),
                            Text(
                              'Or continue with',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 16,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade400,
                                thickness: 0.8,
                                indent: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),
                        CustomButton(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          borderColor: Colors.white,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Image.asset('assets/google.png'),
                              Text('Google'),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              children: [
                                TextSpan(text: 'Already have an account?'),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = () => getIt<AppRouter>().pop(),
                                  text: ' Log In',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

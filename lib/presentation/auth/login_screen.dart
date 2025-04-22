import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_taskhub/logic/auth/auth_cubit.dart';
import 'package:mini_taskhub/logic/auth/auth_state_cubit.dart';
import 'package:mini_taskhub/presentation/auth/signup_screen.dart';
import 'package:mini_taskhub/presentation/dashboard/dashboard_screen.dart';
import 'package:mini_taskhub/routes/app_routes.dart';
import 'package:mini_taskhub/services/service_locator.dart';
import 'package:mini_taskhub/utils/utils.dart';
import 'package:mini_taskhub/widgets/custom_button.dart';
import 'package:mini_taskhub/widgets/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void handleLogin() {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      getIt<AuthCubit>().signIn(
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthCubit, AuthStateCubit>(
      bloc: getIt<AuthCubit>(),
      listener: (context, state) {
        if (state.status == AuthStatus.error) {
          Utils.showSnackBar(
            context,
            state.error.toString(),
            isError: true,
          );
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
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          // fit: BoxFit.contain,
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
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
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
                        const SizedBox(height: 20),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.04),
                        CustomButton(
                          onPressed: handleLogin,
                          text: 'Log In',
                        ),
                        SizedBox(height: size.height * 0.04),
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
                        SizedBox(height: size.height * 0.04),
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
                            spacing: 20,
                            children: [
                              Image.asset('assets/google.png'),
                              Text('Continue with Google'),
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
                                TextSpan(text: 'Don’t have an account? '),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = () => getIt<AppRouter>().push(const SignupScreen()),
                                  text: 'Sign up',
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

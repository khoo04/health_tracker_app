import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/widgets/loader.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/core/utils/show_snackbar.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_tracker_app/features/auth/presentation/pages/register_page.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_password_field.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Welcome",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      "assets/images/healthcare_logo.png",
                      width: MediaQuery.sizeOf(context).width * 0.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthInputField(
                      hintText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthPasswordField(
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppPallete.primaryColor,
                            ),
                          ),
                          onTap: () => eLog("TODO: Not implement yet"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      buttonText: "Log In",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLogin(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.routeName);
                      },
                      child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: AppPallete.primaryColor,
                                    ),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

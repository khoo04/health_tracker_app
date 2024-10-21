import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/pages/user_agreement_policy.dart';
import 'package:health_tracker_app/core/common/widgets/loader.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';
import 'package:health_tracker_app/core/utils/show_snackbar.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:health_tracker_app/features/auth/presentation/widgets/auth_password_field.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool isRead = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: AppPallete.transparentColor,
            leadingWidth: 80,
            leading: IconButton.filled(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              alignment: Alignment.center,
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppPallete.greyColor,
              ),
            ),
          ),
        ],
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                } else if (state is AuthSuccess) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Row(
                      //TODO: Implement the Progress Indicator?
                      children: [
                        Container(
                          height: 100,
                          width: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Your health journey start here",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              AuthInputField(
                                hintText: "First Name",
                                prefixIcon: const Icon(Icons.badge),
                                controller: firstNameController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AuthInputField(
                                hintText: "Last Name",
                                prefixIcon: const Icon(Icons.badge),
                                controller: lastNameController,
                              ),
                              const SizedBox(
                                height: 50,
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
                                hintText: "Password",
                                controller: passwordController,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AuthPasswordField(
                                hintText: "Confirm Password",
                                controller: passwordController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //Remove Default Padding
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                            value: isRead,
                                            onChanged: (value) {
                                              setState(() {
                                                isRead = value!;
                                              });
                                            }),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text.rich(
                                          softWrap: true,
                                          TextSpan(
                                            text: "I've read and agreed to ",
                                            children: [
                                              TextSpan(
                                                text:
                                                    "User Agreement & Privacy Policy",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color:
                                                      AppPallete.primaryColor,
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                UserAgreementPolicy
                                                                    .routeName);
                                                      },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                              const SizedBox(height: 10),
                              AuthButton(
                                buttonText: "Sign Up",
                                onPressed: isRead ? _signUp : null,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Already have an account? ",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    children: [
                                      TextSpan(
                                        text: "Sign In",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: AppPallete.primaryColor,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //Reserved Space to Scroll
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }

  void _signUp() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
            ),
          );
    }
  }
}

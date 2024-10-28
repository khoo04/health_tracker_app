import 'package:flutter/material.dart';
import 'package:health_tracker_app/core/theme/app_pallete.dart';

class UserAgreementPolicy extends StatelessWidget {
  static const routeName = "/agreement-policy";
  const UserAgreementPolicy({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "User Agreement",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: const Text.rich(
                    TextSpan(
                      text:
                          "Welcome to HealthQuest! By downloading, accessing, or using our mobile application, you agree to be bound by this User Agreement. Please read the following terms carefully.\n",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "\n1. Acceptance of Terms\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                "By using the HealthQuest app, you agree to comply with and be bound by these terms and conditions. If you do not agree to these terms, you should not use the app.\n"),
                        TextSpan(
                          text: "\n2. Use of the App\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: """
You must be at least [age] years old to use [App Name].
                                    
You are responsible for any activity that occurs under your account. 

You agree not to use HealthQuest for any unlawful or prohibited activity."""),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  height: 50,
                ),
                Text(
                  "Privacy Policy",
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: const Text.rich(
                    TextSpan(
                      text:
                          "At HealthQuest, we value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data.\n",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: [
                        TextSpan(
                          text: "\n1. Information We Collect\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                """Personal Information: We may collect personal information such as your name, email address, and phone number when you create an account.
        
Usage Data: We may collect information about how you use the app, such as features accessed, time spent, and preferences.
        
Location Data: With your permission, we may collect location data to provide location-based services.\n"""),
                        TextSpan(
                          text: "\n2. How We Use Your Information\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: """
To provide, maintain, and improve the app’s functionality.
        
To communicate with you regarding updates, promotions, or customer support.
        
To analyze app usage and trends to enhance user experience."""),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

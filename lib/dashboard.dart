import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  /// Empty Dashboard That Implements the Logout Function
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Tracker App"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Text("Dashboard"),
    );
  }
}

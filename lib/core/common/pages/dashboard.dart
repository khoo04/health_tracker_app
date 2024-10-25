import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text("Dashboard"),
        ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            child: Text("Log out"))
      ]),
    );
  }
}

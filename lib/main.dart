import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/common/pages/user_agreement_policy.dart';
import 'package:health_tracker_app/core/theme/theme.dart';
import 'package:health_tracker_app/app_wrapper.dart';
import 'package:health_tracker_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_tracker_app/features/auth/presentation/pages/login_page.dart';
import 'package:health_tracker_app/features/auth/presentation/pages/register_page.dart';
import 'package:health_tracker_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:health_tracker_app/init_dependencies.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<ProfileBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp(
        title: 'My Health Tracker',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeMode,
        initialRoute: '/',
        routes: {
          '/': (context) => const AppWrapper(),
          LoginPage.routeName: (context) => const LoginPage(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          UserAgreementPolicy.routeName: (context) =>
              const UserAgreementPolicy(),
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/bloc/article/bloc/artc_bloc.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
import 'package:health_tracker_app/bottom.dart';
import 'package:health_tracker_app/model/article_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://oezjjnvxfkhirqljetig.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9lempqbnZ4ZmtoaXJxbGpldGlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkwOTAzOTksImV4cCI6MjA0NDY2NjM5OX0.Lh69F4FPg0i0Jd3yf0wcznN2lCtG5pxYvOKqsx3xMjc");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => ArtcBloc())
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: FramePage()),
    );
  }
}

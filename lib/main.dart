import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_tracker_app/bloc/article/bloc/artc_bloc.dart';
import 'package:health_tracker_app/bloc/homepage/home_bloc.dart';
import 'package:health_tracker_app/frame.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://oezjjnvxfkhirqljetig.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9lempqbnZ4ZmtoaXJxbGpldGlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkwOTAzOTksImV4cCI6MjA0NDY2NjM5OX0.Lh69F4FPg0i0Jd3yf0wcznN2lCtG5pxYvOKqsx3xMjc");
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
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
      child: MaterialApp(
          theme: Provider.of<ThemeProvider>(context).themeData,
          debugShowCheckedModeBanner: false,
          home: FramePage()),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = _lightMode;
  ThemeData get themeData => _themeData;

  static const Color mainColor = Color.fromARGB(255, 20, 150, 126);
  static const Color secondColor = Color.fromARGB(255, 226, 252, 214);

  void toggleTheme() {
    _themeData = _themeData == _lightMode ? _darkMode : _lightMode;
    notifyListeners();
  }

  static final _lightMode = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    ),
    textTheme: GoogleFonts.montserratTextTheme(),
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color.fromARGB(255, 248, 249, 250),
    appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.black)),
  );

  static final _darkMode = ThemeData();
}

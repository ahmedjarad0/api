import 'package:api/prefs/shared_perf.dart';
import 'package:api/screen/app/users_screen.dart';
import 'package:api/screen/auth/login_screen.dart';
import 'package:api/screen/auth/register_screen.dart';
import 'package:api/screen/core/launch_screen.dart';
import 'package:api/screen/images/images_screen.dart';
import 'package:api/screen/images/upload_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPerfController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/users_screen': (context) => const UsersScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/images_screen': (context) => const ImageScreen(),
        '/upload_image_screen': (context) => const UploadImageScreen(),
      },
      theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            elevation: 0,
            titleTextStyle: GoogleFonts.poppins(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          )),
    );
  }
}

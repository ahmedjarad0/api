import 'package:api/api/auth_api_controller.dart';
import 'package:api/helpers/context_extention.dart';
import 'package:api/models/api_response.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  bool _obscureText = true;
  late String _language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back ..',
              style: GoogleFonts.cairo(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Enter email & password',
                style: GoogleFonts.cairo(
                    fontSize: 18,
                    color: Colors.black38,
                    height: 1,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              textInputType: TextInputType.emailAddress,
              hintText: 'Email',
              prefixIcon: Icons.email,
              controller: _emailEditingController,
            ),
            const SizedBox(
              height: 15,
            ),
            AppTextField(
              textInputType: TextInputType.text,
              hintText: 'password',
              prefixIcon: Icons.lock,
              obscure: _obscureText,
              controller: _passwordEditingController,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _performLogin();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                'LOGIN',
                style: GoogleFonts.cairo(fontSize: 16),
              ),
            ),
            Row(
              children: [
                const Text('Don\'t hava an account '),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: const Text('Create Now !'))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> _login() async {
    ApiResponse apiResponse = await AuthApiController().login(
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
    if (apiResponse.success) {
      Navigator.pushReplacementNamed(context, '/users_screen');
    }
    context.showSnackBar(
        message: apiResponse.message, error: !apiResponse.success);
  }
}

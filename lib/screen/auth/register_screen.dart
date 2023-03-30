import 'package:api/api/auth_api_controller.dart';
import 'package:api/helpers/context_extention.dart';
import 'package:api/models/api_response.dart';
import 'package:api/models/student.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../widget/app_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailEditingController;
  late TextEditingController _nameEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _genderEditingController;
  bool _obscureText = true;
  String _valueGender = 'M';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _nameEditingController = TextEditingController();
    _genderEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _nameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Register Now',
                style: GoogleFonts.cairo(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Enter below ..',
                  style: GoogleFonts.cairo(
                      fontSize: 18,
                      color: Colors.black38,
                      height: 1,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              AppTextField(
                textInputType: TextInputType.name,
                hintText: 'name',
                prefixIcon: Icons.person,
                controller: _nameEditingController,
              ),
              const SizedBox(
                height: 15,
              ),
              AppTextField(
                textInputType: TextInputType.emailAddress,
                hintText: 'email',
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
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                        title: const Text('Male'),
                        value: 'M',
                        groupValue: _valueGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _valueGender = value;
                            });
                          }
                        }),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                        title: const Text('Famale'),
                        value: 'F',
                        groupValue: _valueGender,
                        onChanged: (String? value) {
                          if (value != null) {
                            setState(() {
                              _valueGender = value;
                            });
                          }
                        }),
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _performRegister();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'register',
                  style: GoogleFonts.cairo(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _performRegister() {
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> _register() async {
    ///TODO : Call Api register function
    ApiResponse apiResponse =
        await AuthApiController().register(student: student);
    if (apiResponse.success) {
      Navigator.pop(context);
    }
    context.showSnackBar(
        message: apiResponse.message, error: !apiResponse.success);
  }

  Student get student {
    Student student = Student();
    student.fullName = _nameEditingController.text;
    student.password = _passwordEditingController.text;
    student.gender = _valueGender;
    student.email = _emailEditingController.text;
    return student;
  }
}

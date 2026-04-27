import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/core/colors.dart';
import 'package:imdb/shared/widgets/primary_button.dart';
import 'package:imdb/shared/widgets/input_field.dart';
import 'package:imdb/shared/widgets/password_input_field.dart';
import 'package:imdb/shared/widgets/secondary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _getStrengthText() {
    if (strength <= 0.25) return "WEAK";
    if (strength <= 0.5) return "FAIR";
    if (strength <= 0.75) return "GOOD";
    return "STRONG";
  }

  late String password;

  double strength = 0;

  void checkPassword(String val) {
    password = val.trim();
    double newStrength = 0;

    if (password.isEmpty) {
      newStrength = 0;
    } else if (password.length <= 3) {
      // 1 bar: Very Weak
      newStrength = 1 / 4;
    } else if (password.length <= 6) {
      // 2 bars: Fair
      newStrength = 2 / 4;
    } else if (password.length <= 9) {
      // 3 bars: Good
      newStrength = 3 / 4;
    } else {
      // 4 bars: Strong
      newStrength = 4 / 4;
    }

    setState(() {
      strength = newStrength;
    });
  }

  Future<void> _registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'fullName': _nameController.text.trim(),
            'email': _emailController.text.trim(),
            'createdAt': DateTime.now(),
          });

      print("User Registered and Data Saved!");
      context.go('/login');
    } catch (e) {
      print("Registration Failed: $e");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: Container(
          height: 40,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: Center(
            child: Text(
              'MDB',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Join The Club.',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 8),
            Text(
              'Unlock personalized recommendations, watchlists, and exclusive movie trivia.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'FullName',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 8),

                    InputField(
                      controller: _nameController,
                      hintText: 'Enter Your Name',
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length < 3) {
                          return 'Enter Valid Name';
                        } else {}
                        return null;
                      },
                    ),

                    SizedBox(height: 20),
                    Text(
                      'EmailAddress',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 8),

                    InputField(
                      controller: _emailController,
                      hintText: 'Example@gmail.com',
                      validator: (value) {
                        if (value == null ||
                            !value.contains('@') ||
                            value.trim().isEmpty) {
                          return 'Enter Valid Email Address';
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: 8),

                    PasswordInputField(
                      controller: _passwordController,
                      onChange: (val) => checkPassword(val),
                      hintText: 'Enter Your Password',
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.length < 6) {
                          return 'Enter Valid Password';
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox(height: 8),
                    Row(
                      children: [
                        ...List.generate(4, (index) {
                          // Logic: if index 0, check if strength >= 0.25, etc.
                          bool isFilled = strength >= (index + 1) / 4;

                          return Expanded(
                            child: Container(
                              height: 4,
                              margin: EdgeInsets.only(
                                right: index == 3 ? 0 : 4,
                              ),
                              decoration: BoxDecoration(
                                // Use your AppColors or yellow from the design
                                color: isFilled
                                    ? const Color(0xFFFFD740)
                                    : Colors.white12,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        Text(
                          _getStrengthText(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text.rich(
              TextSpan(
                text: "By signing up, you agree to our ",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: const TextStyle(
                      color: Color(0xFFFFD740), // Your theme yellow
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // print("Navigate to Terms of Service");
                      },
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      color: Color(0xFFFFD740),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // print("Navigate to Privacy Policy");
                      },
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),
            SizedBox(height: 30),
            PrimaryButton(
              label: 'Create Account',
              onPressed: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty &&
                    _nameController.text.isNotEmpty) {
                  _registerUser();
                }
              },
              labelColor: Colors.black,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "OR CONTINUE WITH",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    label: 'Google',
                    showIcon: true,
                    icon: Icons.g_mobiledata,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: SecondaryButton(
                    label: 'Apple',
                    showIcon: true,
                    icon: Icons.apple,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Text.rich(
                TextSpan(
                  text: "Already have an account? ",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                  children: [
                    TextSpan(
                      text: "Log In",
                      style: const TextStyle(
                        color: Color(0xFFFFD740), // Your MDB yellow accent
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pop();
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

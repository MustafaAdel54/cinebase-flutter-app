import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb/shared/widgets/primary_button.dart';
import 'package:imdb/shared/widgets/input_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                "Forgot",
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 40),
              ),
              Text(
                "Password?",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Enter the email address associated with your account and we'll send you a link to reset your password.",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 50),

              // Email Field with Prefix Icon
              Text(
                "EMAIL ADDRESS",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              InputField(
                controller: _emailController,
                hintText: 'name@example.com',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Send Reset Link.',
                onPressed: () {},
                labelColor: Colors.black,
              ),
              SizedBox(height: 300),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    context.pop('/login');
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.grey,
                    size: 16,
                  ),
                  label: Text(
                    "Back to Login",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:desiroo/core/widgets/styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: StyledConstants.edgeInsetsHorizontal),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StyledTextField(
                    placeholder: 'Email',
                    controller: _emailController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: StyledConstants.edgeInsetsVertical)),
                  StyledTextField(
                    placeholder: 'Password',
                    controller: _passwordController,
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: StyledConstants.edgeInsetsVertical)),
                  FilledButton(
                    child: const Text('Register'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text('Already have account'),
                    onPressed: () {
                      context.go('/login');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

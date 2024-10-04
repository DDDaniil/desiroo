import 'package:desiroo/core/constants/styled_constants.dart';
import 'package:desiroo/core/widgets/styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    child: const Text('Login'),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text('Create account'),
                    onPressed: () {
                      context.go('/registration');
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

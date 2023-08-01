// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../atom/register_form.dart';
import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<IconButton> listOfActions = [
      IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationName: 'Story App',
            applicationVersion: '1.0.0',
            applicationIcon: const Icon(
              Icons.book,
            ),
            children: const [
              Text(
                'This is a simple app to add and share you simple story with dicoding API',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RouteHelper.toTitle(AppRoute.register),
        ),
        actions: listOfActions,
      ),
      body: RegisterForm(
        formKey: _formKey,
        nameController: _nameController,
        emailController: _emailController,
        passwordController: _passwordController,
      ),
    );
  }
}

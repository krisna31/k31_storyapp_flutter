// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import '../../atom/login_form.dart';
import '../../routes/app_route.dart';
import '../../routes/route_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _disposeAllController();
    super.dispose();
  }

  void _disposeAllController() {
    _emailController.dispose();
    _passwordController.dispose();
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
          RouteHelper.toTitle(AppRoute.login),
        ),
        actions: listOfActions,
      ),
      body: LoginForm(
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
      ),
    );
  }
}

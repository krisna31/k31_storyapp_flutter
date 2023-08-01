// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:k31_storyapp_flutter/enum/res_state.dart';
import 'package:k31_storyapp_flutter/provider/auth_provider.dart';
import 'package:k31_storyapp_flutter/util/string_helper.dart';
import 'package:provider/provider.dart';

import '../../atom/href.dart';
import '../../atom/image_with_network.dart';
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
      body: LoginForm(
        formKey: _formKey,
        emailController: _emailController,
        passwordController: _passwordController,
        nameController: _nameController,
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController nameController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        _nameController = nameController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        if (value.state == ResState.successRegister) {
          context.go(RouteHelper.toPath(AppRoute.login));
        }
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ImageWithNetwork(
                  url:
                      'https://source.unsplash.com/600x300/?story,register,person',
                  cacheKey: 'register-image-page',
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Name",
                        ),
                        validator: _validateName,
                        controller: _nameController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        validator: _validateEmail,
                        controller: _emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: "Password",
                        ),
                        validator: _validatePassword,
                        controller: _passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await value.register(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );
                          }
                        },
                        child: value.state == ResState.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text('Register'),
                      ),
                      const SizedBox(height: 20),
                      HrefTag(
                        placeholder: 'Already have an account',
                        href: RouteHelper.toPath(AppRoute.login),
                      ),
                      const SizedBox(height: 20),
                      Builder(
                        builder: (context) {
                          if (value.state == ResState.error) {
                            return Text(
                              value.message,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return const Text('');
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String? _validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? _validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!StringHelper.isValidEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }
}

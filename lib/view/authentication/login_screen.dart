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
          passwordController: _passwordController),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: ImageWithNetwork(
                  url: 'https://source.unsplash.com/600x300/?story,book',
                  cacheKey: 'login-image-pages',
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
                            await value.login(
                              _emailController.text,
                              _passwordController.text,
                            );
                            if (value.isLogin) {
                              context.go("/");
                            }
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
                            : const Text('Login'),
                      ),
                      const SizedBox(height: 20),
                      HrefTag(
                        placeholder: 'Register new account',
                        href: RouteHelper.toPath(
                          AppRoute.register,
                        ),
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
}

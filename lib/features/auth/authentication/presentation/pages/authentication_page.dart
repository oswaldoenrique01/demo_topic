import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:commons/commons.dart';
import '../../../../../core/router/app_router.dart';
import '../bloc/authentication_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<AuthenticationBloc>()..add(AuthenticationStarted()),
      child: const AuthenticationPageView(),
    );
  }
}

class AuthenticationPageView extends StatelessWidget {
  const AuthenticationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is AuthenticationAuthenticated) {
          if (context.mounted) {
            NavigationHelper.goToAndReplace(context, AppRouter.selection.path);
          }
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return const AuthenticationPageContainer();
      },
    );
  }
}

class AuthenticationPageContainer extends StatefulWidget {
  const AuthenticationPageContainer({super.key});

  @override
  State<AuthenticationPageContainer> createState() =>
      _AuthenticationPageContainerState();
}

class _AuthenticationPageContainerState
    extends State<AuthenticationPageContainer> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido*';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Correo invalido*';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido*';
                  }
                  if (value.length < 6) {
                    return 'Minimo 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthenticationBloc>().add(
                      AuthenticationLoginRequested(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:doctor247_doutor/src/blocs/login/login_bloc.dart';

enum AuthMode { Forgot, Login }

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AccountScreen());
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 50),
                  const Image(
                    image: AssetImage('assets/images/logo-new.png'),
                    width: 300,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  final _isLoading = false;

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Forgot;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return _authMode == AuthMode.Login
        ? _AuthCardLogin(deviceSize, _switchAuthMode, _formKey, _isLoading)
        : _AuthCardForgotPwd(deviceSize, _switchAuthMode, _formKey, _isLoading);
  }
}

class _AuthCardLogin extends StatelessWidget {
  const _AuthCardLogin(
    this.deviceSize,
    this.switchAuthMode,
    this.formKey,
    this.isLoading,
  );

  final Size deviceSize;
  final Key formKey;
  final bool isLoading;
  final void Function()? switchAuthMode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text(
                      'Falha na Autenticação. Verifique o e-mail e Palavra Passe e tente novamente.')),
            );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        color: const Color(0xE6FFFFFF),
        child: Container(
          height: 300,
          constraints: const BoxConstraints(minHeight: 300),
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _EmailInput(),
                  _PasswordInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    _LoginButton(),
                  TextButton(
                    onPressed: switchAuthMode,
                    child: const Text('ESQUECEU A PALAVRA PASSE?'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthCardForgotPwd extends StatelessWidget {
  const _AuthCardForgotPwd(
    this.deviceSize,
    this.switchAuthMode,
    this.formKey,
    this.isLoading,
  );

  final Size deviceSize;
  final Key formKey;
  final bool isLoading;
  final void Function() switchAuthMode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                  content: Text(
                      'Houve um erro no envio da senha. Verifique a conexão e tente novamente.')),
            );
        } else if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(
                      'Um e-mail foi enviado para ${state.userEmail.value} com uma senha temporária.')),
            );
          switchAuthMode();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        color: const Color(0xE6FFFFFF),
        child: Container(
          height: 235,
          constraints: const BoxConstraints(minHeight: 200),
          width: deviceSize.width * 0.75,
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _EmailInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    const CircularProgressIndicator()
                  else
                    _ForgotPwdButton(),
                  TextButton(
                    onPressed: switchAuthMode,
                    child: const Text('VOLTAR AO LOGIN'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.userEmail != current.userEmail,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
              labelText: 'E-mail',
              errorText: state.userEmail.invalid ? 'E-mail Inválido' : null,
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary)),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Palavra Passe',
              errorText:
                  state.password.invalid ? 'Palavra Passe Inválida' : null,
              labelStyle:
                  TextStyle(color: Theme.of(context).colorScheme.secondary)),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: const Text('ENTRAR'),
              );
      },
    );
  }
}

class _ForgotPwdButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: state.userEmail.valid
                    ? () => context
                        .read<LoginBloc>()
                        .add(LoginForgotPassword(state.userEmail.value))
                    : null,
                child: const Text('ENVIAR'),
              );
      },
    );
  }
}

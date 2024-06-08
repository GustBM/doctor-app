import 'package:doctor247_doutor/src/blocs/newPassword/new_password_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AccountChangePasswordScreen extends StatefulWidget {
  const AccountChangePasswordScreen({super.key, this.goBack = false});
  final bool goBack;

  static Route<void> route({bool goBack = false}) {
    return MaterialPageRoute<void>(
        builder: (_) => AccountChangePasswordScreen(
              goBack: goBack,
            ));
  }

  @override
  State<AccountChangePasswordScreen> createState() =>
      _AccountChangePasswordScreenState();
}

class _AccountChangePasswordScreenState
    extends State<AccountChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    var passwordVisible = false;

    void changePwdVisibility() {
      setState(() {
        passwordVisible = !passwordVisible;
      });
    }

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
                    child: BlocProvider(
                      create: (context) {
                        return context.read<NewPasswordBloc>();
                      },
                      child: BlocListener<NewPasswordBloc, NewPasswordState>(
                        listener: (context, state) {
                          if (state.status.isSubmissionFailure) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Houve um erro! Verifique as informações e tente novamanente.')),
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
                            constraints: const BoxConstraints(minHeight: 400),
                            width: deviceSize.width * 0.75,
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    _CurrentPasswordInput(
                                      passwordVisible: passwordVisible,
                                      switchPwdVisibility: changePwdVisibility,
                                    ),
                                    _NewPasswordInput(
                                      passwordVisible: passwordVisible,
                                      switchPwdVisibility: changePwdVisibility,
                                    ),
                                    _NewPasswordConfirmationInput(
                                      passwordVisible: passwordVisible,
                                      switchPwdVisibility: changePwdVisibility,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _LoginButton(),
                                    widget.goBack
                                        ? TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('TROCAR DEPOIS'),
                                          )
                                        : TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('VOLTAR'),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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

class _CurrentPasswordInput extends StatefulWidget {
  const _CurrentPasswordInput({
    required this.passwordVisible,
    required this.switchPwdVisibility,
  });

  final bool passwordVisible;
  final void Function() switchPwdVisibility;

  @override
  State<_CurrentPasswordInput> createState() => _CurrentPasswordInputState();
}

class _CurrentPasswordInputState extends State<_CurrentPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          previous.currentPassword != current.currentPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('newPwdForm_oldPasswordInput_textField'),
          onChanged: (password) => context
              .read<NewPasswordBloc>()
              .add(NewPasswordCurrentPasswordChanged(password)),
          obscureText: !widget.passwordVisible,
          decoration: InputDecoration(
            labelText: 'Palavra Passe Atual',
            hintText: 'A senhar recebida pelo e-mail',
            hintTextDirection: TextDirection.ltr,
            errorText:
                state.currentPassword.invalid ? 'Palavra Passe Inválida' : null,
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            suffixIcon: IconButton(
              icon: Icon(
                widget.passwordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: widget.switchPwdVisibility,
            ),
          ),
        );
      },
    );
  }
}

class _NewPasswordInput extends StatelessWidget {
  const _NewPasswordInput({
    required this.passwordVisible,
    required this.switchPwdVisibility,
  });

  final bool passwordVisible;
  final void Function() switchPwdVisibility;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          previous.newPassword != current.newPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('newPwdForm_newPasswordInput_textField'),
          onChanged: (password) => context
              .read<NewPasswordBloc>()
              .add(NewPasswordNewPasswordChanged(password)),
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            labelText: 'Nova Palavra Passe',
            errorText: state.newPasswordConfirmation.invalid
                ? 'Palavra Passe Inválida'
                : null,
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: switchPwdVisibility,
            ),
          ),
        );
      },
    );
  }
}

class _NewPasswordConfirmationInput extends StatelessWidget {
  const _NewPasswordConfirmationInput({
    required this.passwordVisible,
    required this.switchPwdVisibility,
  });

  final bool passwordVisible;
  final void Function() switchPwdVisibility;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
      buildWhen: (previous, current) =>
          previous.newPasswordConfirmation != current.newPasswordConfirmation,
      builder: (context, state) {
        return TextField(
          key: const Key('newPwdForm_newPasswordonfirmationInput_textField'),
          onChanged: (password) => context
              .read<NewPasswordBloc>()
              .add(NewPasswordNewPasswordConfirmationChanged(password)),
          obscureText: !passwordVisible,
          decoration: InputDecoration(
            labelText: 'Confirmar Nova Palavra Passe',
            errorText: state.newPasswordConfirmation.invalid
                ? 'Palavra Passe Inválida'
                : null,
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.secondary),
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: switchPwdVisibility,
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
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
                        context
                            .read<NewPasswordBloc>()
                            .add(const NewPasswordSubmitted());
                      }
                    : null,
                child: const Text('ENTRAR'),
              );
      },
    );
  }
}

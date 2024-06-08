import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:doctor247_doutor/src/models/new_password.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const NewPasswordState()) {
    on<NewPasswordCurrentPasswordChanged>(_onNewPasswordCurrentPasswordChanged);
    on<NewPasswordNewPasswordChanged>(_onNewPasswordNewPasswordChanged);
    on<NewPasswordNewPasswordConfirmationChanged>(
        _onNewPasswordNewPasswordConfirmationChanged);
    on<NewPasswordSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onNewPasswordCurrentPasswordChanged(
    NewPasswordCurrentPasswordChanged event,
    Emitter<NewPasswordState> emit,
  ) {
    final currentPassword = CurrentPassword.dirty(event.currentPassword);
    emit(
      state.copyWith(
        currentPassword: currentPassword,
        status: Formz.validate([
          currentPassword,
          state.newPassword,
          state.newPasswordConfirmation,
        ]),
      ),
    );
  }

  void _onNewPasswordNewPasswordChanged(
    NewPasswordNewPasswordChanged event,
    Emitter<NewPasswordState> emit,
  ) {
    final newPassword = NewPassword.dirty(event.newPassword);
    emit(
      state.copyWith(
        newPassword: newPassword,
        status: Formz.validate([
          state.currentPassword,
          newPassword,
          state.newPasswordConfirmation,
        ]),
      ),
    );
  }

  void _onNewPasswordNewPasswordConfirmationChanged(
    NewPasswordNewPasswordConfirmationChanged event,
    Emitter<NewPasswordState> emit,
  ) {
    final newPasswordConfirmation =
        NewPasswordConfirmation.dirty(event.newPasswordConfirmation);
    emit(
      state.copyWith(
        newPasswordConfirmation: newPasswordConfirmation,
        status: Formz.validate([
          state.currentPassword,
          state.newPassword,
          newPasswordConfirmation,
        ]),
      ),
    );
  }

  void _onSubmitted(
    NewPasswordSubmitted event,
    Emitter<NewPasswordState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.newPassword(
          currentPassword: state.currentPassword.value,
          newPassword: state.newPassword.value,
          newPasswordConfirmation: state.newPasswordConfirmation.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}

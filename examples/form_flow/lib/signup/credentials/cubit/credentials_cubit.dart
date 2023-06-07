import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz_inputs/formz_inputs.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit() : super(const CredentialsState());

  void changeEmail(String value) {
    final email = EmailFormInput.dirty(value);
    emit(
      state.copyWith(email: email),
    );
  }

  void changeName(String value) {
    final name = NameFormInput.dirty(value);
    emit(
      state.copyWith(name: name),
    );
  }
}

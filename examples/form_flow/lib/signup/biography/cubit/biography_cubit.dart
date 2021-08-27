import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:formz_inputs/formz_inputs.dart';

part 'biography_state.dart';

class BiographyCubit extends Cubit<BiographyState> {
  BiographyCubit() : super(const BiographyState());

  void changeBiography(String value) {
    final biography = BiographyFormInput.dirty(value);
    emit(
      BiographyState(
        biography: biography,
        status: Formz.validate([biography]),
      ),
    );
  }
}

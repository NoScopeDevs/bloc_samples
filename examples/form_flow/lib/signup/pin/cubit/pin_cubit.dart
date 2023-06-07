import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz_inputs/formz_inputs.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(const PinState());

  void changePin(String value) {
    final pin = PinFormInput.dirty(value);
    emit(PinState(pin: pin));
  }
}

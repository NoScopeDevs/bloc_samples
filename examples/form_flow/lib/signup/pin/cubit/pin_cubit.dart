import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial());
}

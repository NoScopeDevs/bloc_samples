part of 'pin_cubit.dart';

class PinState extends Equatable {
  const PinState({
    this.pin = const PinFormInput.pure(),
    this.status = FormzStatus.pure,
  });

  final PinFormInput pin;
  final FormzStatus status;

  @override
  List<Object> get props => [pin, status];

  PinState copyWith({
    PinFormInput? pin,
    FormzStatus? status,
  }) {
    return PinState(
      pin: pin ?? this.pin,
      status: status ?? this.status,
    );
  }
}

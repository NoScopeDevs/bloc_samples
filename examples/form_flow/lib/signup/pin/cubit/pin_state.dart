part of 'pin_cubit.dart';

class PinState extends Equatable {
  const PinState({
    this.pin = const PinFormInput.pure(),
  });

  final PinFormInput pin;

  @override
  List<Object> get props => [pin];

  PinState copyWith({
    PinFormInput? pin,
  }) {
    return PinState(
      pin: pin ?? this.pin,
    );
  }
}

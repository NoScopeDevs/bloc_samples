part of 'biography_cubit.dart';

class BiographyState extends Equatable {
  const BiographyState({
    this.biography = const BiographyFormInput.pure(),
    this.status = FormzStatus.pure,
  });

  final BiographyFormInput biography;
  final FormzStatus status;

  @override
  List<Object> get props => [biography, status];

  BiographyState copyWith({
    BiographyFormInput? biography,
    FormzStatus? status,
  }) {
    return BiographyState(
      biography: biography ?? this.biography,
      status: status ?? this.status,
    );
  }
}

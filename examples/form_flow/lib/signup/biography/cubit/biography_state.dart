part of 'biography_cubit.dart';

class BiographyState extends Equatable {
  const BiographyState({
    this.biography = const BiographyFormInput.pure(),
  });

  final BiographyFormInput biography;

  @override
  List<Object> get props => [biography];

  BiographyState copyWith({
    BiographyFormInput? biography,
  }) {
    return BiographyState(biography: biography ?? this.biography);
  }
}

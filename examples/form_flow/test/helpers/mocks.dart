import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:form_flow/signup/signup.dart';
import 'package:formz_inputs/formz_inputs.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';

/// * Mocks

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class MockSignUpBloc extends MockBloc<SignUpEvent, SignUpState>
    implements SignUpBloc {}

class MockCredentialsCubit extends MockCubit<CredentialsState>
    implements CredentialsCubit {}

class MockBiographyCubit extends MockCubit<BiographyState>
    implements BiographyCubit {}

class MockPinCubit extends MockCubit<PinState> implements PinCubit {}

class MockNameFormInput extends Mock implements NameFormInput {}

class MockEmailFormInput extends Mock implements EmailFormInput {}

class MockBiographyFormInput extends Mock implements BiographyFormInput {}

class MockPinFormInput extends Mock implements PinFormInput {}

class MockUser extends Mock implements User {}

/// * Fakes

class FakeBloc extends Fake implements Bloc<Object, Object> {}

class FakeSignUpState extends Fake implements SignUpState {}

class FakeCredentialsState extends Fake implements CredentialsState {}

class FakeBiographyState extends Fake implements BiographyState {}

class FakePinState extends Fake implements PinState {}

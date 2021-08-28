import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile_accounts/profile/profile.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class FakeProfileState extends Fake implements ProfileState {}

class FakeProfileEvent extends Fake implements ProfileEvent {}

class FakeProfileAccountAdded extends Fake implements ProfileAccountAdded {}

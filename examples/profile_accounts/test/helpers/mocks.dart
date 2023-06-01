import 'package:bloc_test/bloc_test.dart';
import 'package:profile_accounts/profile/profile.dart';

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

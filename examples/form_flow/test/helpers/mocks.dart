import 'package:bloc_test/bloc_test.dart';
import 'package:form_flow/app/app.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

class MockUser extends Mock implements User {}

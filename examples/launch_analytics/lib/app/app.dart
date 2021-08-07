import 'package:analytics_repository/analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_analytics/app/bloc/app_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AnalyticsRepository localAnalyticsRepository,
  })  : _localAnalyticsRepository = localAnalyticsRepository,
        super(key: key);

  final AnalyticsRepository _localAnalyticsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _localAnalyticsRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          localAnalyticsRepository: _localAnalyticsRepository,
        )..add(const AppAnalyticsChecked()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppAnalyticsLoaded) {
            final snackBar = SnackBar(
              content: Text('You have entered ${state.openingsCount} times!'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Hello'),
          ),
        ),
      ),
    );
  }
}

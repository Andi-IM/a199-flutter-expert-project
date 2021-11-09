import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([MoviePopularCubit])
void main() {
  late MockMoviePopularCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMoviePopularCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MoviePopularLoading());
    when(mockNotifier.stream).thenAnswer((_) => const Stream.empty());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(const MoviePopularHasData(<Movie>[]));
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const MoviePopularHasData(<Movie>[])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state)
        .thenReturn(const MoviePopularError('Error Message'));
    when(mockNotifier.stream).thenAnswer(
        (_) => Stream.value(const MoviePopularError('Error Message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

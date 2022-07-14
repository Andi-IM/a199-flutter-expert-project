import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/cubit/movie/top_rated/movie_top_rated_cubit.dart';
import 'package:core/presentation/pages/movie/movie_top_rated_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([MovieTopRatedCubit])
void main() {
  late MockMovieTopRatedCubit mockNotifier;

  setUp(() {
    mockNotifier = MockMovieTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(MovieTopRatedLoading());
    when(mockNotifier.stream).thenAnswer((_) => const Stream.empty());

    final loadingFinder = find.byKey(const Key('loading'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(loadingFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(const MovieTopRatedHasData(<Movie>[]));
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const MovieTopRatedHasData(<Movie>[])));

    final listViewFinder = find.byKey(const Key('list'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state)
        .thenReturn(const MovieTopRatedError('Error Message'));
    when(mockNotifier.stream).thenAnswer(
        (_) => Stream.value(const MovieTopRatedError('Error Message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

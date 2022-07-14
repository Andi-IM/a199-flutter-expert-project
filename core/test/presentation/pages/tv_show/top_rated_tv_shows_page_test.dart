import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_shows_page_test.mocks.dart';

@GenerateMocks([TvTopRatedCubit])
void main() {
  late MockTvTopRatedCubit mockNotifier;
  setUp(() {
    mockNotifier = MockTvTopRatedCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedCubit>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(TvTopRatedLoading());
    when(mockNotifier.stream).thenAnswer((_) => const Stream.empty());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(const TvTopRatedHasData(<Tv>[]));
    when(mockNotifier.stream)
        .thenAnswer((_) => Stream.value(const TvTopRatedHasData(<Tv>[])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(const TvTopRatedError('Error Message'));
    when(mockNotifier.stream).thenAnswer(
        (_) => Stream.value(const TvTopRatedError('Error Message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}

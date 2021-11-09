import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/pages/tvshow/popular_tvshow_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_shows_page_test.mocks.dart';

@GenerateMocks([TvPopularCubit])
void main() {
  late MockTvPopularCubit mockBloc;

  setUp(() {
    mockBloc = MockTvPopularCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularCubit>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TvPopularLoading());
    when(mockBloc.stream).thenAnswer((_) => const Stream.empty());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const TvPopularHasData(<Tv>[]));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(const TvPopularHasData(<Tv>[])));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const TvPopularError('Error Message'));
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(const TvPopularError('Error Message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}

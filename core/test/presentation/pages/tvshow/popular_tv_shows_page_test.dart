import 'package:core/presentation/pages/tvshow/popular_tvshow_page.dart';
import 'package:core/presentation/provider/tv_popular_notifier.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_shows_page_test.mocks.dart';

@GenerateMocks([TvPopularNotifier])
void main() {
  late MockTvPopularNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvPopularNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvPopularNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvs).thenReturn([testTv]);

    final itemFinder = find.byType(TvCard);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(itemFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}

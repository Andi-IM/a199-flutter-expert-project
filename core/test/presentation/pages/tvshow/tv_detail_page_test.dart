import 'package:core/presentation/provider/tvshow/detail/tv_detail_cubit.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/presentation/pages/tvshow/tvshow_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailCubit])
void main() {
  late MockTvDetailCubit bloc;

  setUp(() {
    bloc = MockTvDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvDetailCubit>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(bloc.state).thenReturn(
            TvDetailState(
              isDetailLoading: false,
              isRecommendationLoading: false,
              isSaved: false,
              tv: testTvDetail,
              recommendations: const <Tv>[],
              saveErrorMessage: null,
              saveMessage: null,
              message: null,
            ));
        // when(bloc.tvState).thenReturn(RequestState.Loaded);
        // when(bloc.tv).thenReturn(testTvDetail);
        // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
        // when(bloc.tvRecommendations).thenReturn(<Tv>[]);
        // when(bloc.isAddedtoWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to wathclist',
          (WidgetTester tester) async {
        when(bloc.state).thenReturn(
            TvDetailState(
              isDetailLoading: false,
              isRecommendationLoading: false,
              isSaved: true,
              tv: testTvDetail,
              recommendations: const <Tv>[],
              saveErrorMessage: null,
              saveMessage: null,
              message: null,
            ));
        // when(bloc.tvState).thenReturn(RequestState.Loaded);
        // when(bloc.tv).thenReturn(testTvDetail);
        // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
        // when(bloc.tvRecommendations).thenReturn(<Tv>[]);
        // when(bloc.isAddedtoWatchlist).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(
            _makeTestableWidget(const TvShowDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        TvDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          tv: testTvDetail,
          recommendations: const <Tv>[],
          saveErrorMessage: null,
          saveMessage: 'Added to Watchlist',
          message: null,
        );
        // when(bloc.tvState).thenReturn(RequestState.Loaded);
        // when(bloc.tv).thenReturn(testTvDetail);
        // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
        // when(bloc.tvRecommendations).thenReturn(<Tv>[]);
        // when(bloc.isAddedtoWatchlist).thenReturn(false);
        // when(bloc.watchlistMessage).thenReturn('Added to Watchlist');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Added to Watchlist'), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
            when(bloc.state).thenReturn(
                TvDetailState(
                  isDetailLoading: false,
                  isRecommendationLoading: false,
                  isSaved: false,
                  tv: testTvDetail,
                  recommendations: const <Tv>[],
                  saveErrorMessage: 'Failed',
                  saveMessage: null,
                  message: null,
                ));
        // when(bloc.tvState).thenReturn(RequestState.Loaded);
        // when(bloc.tv).thenReturn(testTvDetail);
        // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
        // when(bloc.tvRecommendations).thenReturn(<Tv>[]);
        // when(bloc.isAddedtoWatchlist).thenReturn(false);
        // when(bloc.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(const TvShowDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}

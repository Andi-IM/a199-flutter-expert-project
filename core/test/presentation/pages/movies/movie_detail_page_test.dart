import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/presentation/provider/movie/detail/movie_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailCubit])
void main() {
  late MockMovieDetailCubit bloc;

  setUp(() {
    bloc = MockMovieDetailCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailCubit>.value(
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
          MovieDetailState(
            isDetailLoading: false,
            isRecommendationLoading: false,
            isSaved: false,
            movie: testMovieDetail,
            recommendations: const <Movie>[],
            saveErrorMessage: null,
            saveMessage: null,
            message: null,
          ));
    // when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movie).thenReturn(testMovieDetail);
    // when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    // when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    // when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
        when(bloc.state).thenReturn(
            MovieDetailState(
              isDetailLoading: false,
              isRecommendationLoading: false,
              isSaved: true,
              movie: testMovieDetail,
              recommendations: const <Movie>[],
              saveErrorMessage: null,
              saveMessage: null,
              message: null,
            ));
    // when(bloc.movieState).thenReturn(RequestState.Loaded);
    // when(bloc.movie).thenReturn(testMovieDetail);
    // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
    // when(bloc.movieRecommendations).thenReturn(<Movie>[]);
    // when(bloc.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
        when(bloc.state).thenReturn(
            MovieDetailState(
              isDetailLoading: false,
              isRecommendationLoading: false,
              isSaved: false,
              movie: testMovieDetail,
              recommendations: const <Movie>[],
              saveErrorMessage: null,
              saveMessage: 'Added to Watchlist',
              message: null,
            ));
    // when(bloc.movieState).thenReturn(RequestState.Loaded);
    // when(bloc.movie).thenReturn(testMovieDetail);
    // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
    // when(bloc.movieRecommendations).thenReturn(<Movie>[]);
    // when(bloc.isAddedToWatchlist).thenReturn(false);
    // when(bloc.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

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
            MovieDetailState(
              isDetailLoading: false,
              isRecommendationLoading: false,
              isSaved: false,
              movie: testMovieDetail,
              recommendations: const <Movie>[],
              saveErrorMessage: 'Failed',
              saveMessage: null,
              message: null,
            ));
    // when(bloc.movieState).thenReturn(RequestState.Loaded);
    // when(bloc.movie).thenReturn(testMovieDetail);
    // when(bloc.recommendationState).thenReturn(RequestState.Loaded);
    // when(bloc.movieRecommendations).thenReturn(<Movie>[]);
    // when(bloc.isAddedToWatchlist).thenReturn(false);
    // when(bloc.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}

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

  testWidgets('Should show loading widget when fetching data',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(
      const MovieDetailState(
        isDetailLoading: true,
        isRecommendationLoading: true,
        isSaved: false,
        movie: null,
        recommendations: null,
        saveErrorMessage: null,
        saveMessage: null,
        message: null,
      ),
    );
    when(bloc.stream).thenAnswer((_) => Stream.value(
          const MovieDetailState(
            isDetailLoading: true,
            isRecommendationLoading: true,
            isSaved: false,
            movie: null,
            recommendations: null,
            saveErrorMessage: null,
            saveMessage: null,
            message: null,
          ),
        ));

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byKey(const Key('detail_loading')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(const MovieDetailState(
      isDetailLoading: false,
      isRecommendationLoading: false,
      isSaved: false,
      movie: testMovieDetail,
      recommendations: <Movie>[],
      saveErrorMessage: null,
      saveMessage: null,
      message: null,
    ));
    when(bloc.stream).thenAnswer(
      (_) => Stream.value(
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: false,
          movie: testMovieDetail,
          recommendations: <Movie>[],
          saveErrorMessage: null,
          saveMessage: null,
          message: null,
        ),
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(const MovieDetailState(
      isDetailLoading: false,
      isRecommendationLoading: false,
      isSaved: true,
      movie: testMovieDetail,
      recommendations: <Movie>[],
      saveErrorMessage: null,
      saveMessage: null,
      message: null,
    ));
    when(bloc.stream).thenAnswer((_) => Stream.value(
        const MovieDetailState(
          isDetailLoading: false,
          isRecommendationLoading: false,
          isSaved: true,
          movie: testMovieDetail,
          recommendations: <Movie>[],
          saveErrorMessage: null,
          saveMessage: null,
          message: null,
        ),
      ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(const MovieDetailState(
      isDetailLoading: false,
      isRecommendationLoading: false,
      isSaved: false,
      movie: testMovieDetail,
      recommendations: <Movie>[],
      saveErrorMessage: null,
      saveMessage: null,
      message: null,
    ));
    when(bloc.stream).thenAnswer((_) => Stream.fromIterable([
          const MovieDetailState(
            isDetailLoading: false,
            isRecommendationLoading: false,
            isSaved: false,
            movie: testMovieDetail,
            recommendations: <Movie>[],
            saveErrorMessage: null,
            saveMessage: 'Added to Watchlist',
            message: null,
          ),
          const MovieDetailState(
            isDetailLoading: false,
            isRecommendationLoading: false,
            isSaved: true,
            movie: testMovieDetail,
            recommendations: <Movie>[],
            saveErrorMessage: null,
            saveMessage: null,
            message: null,
          )
        ]));
    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display SnackBar when add to watchlist failed',
      (WidgetTester tester) async {
    when(bloc.state).thenReturn(const MovieDetailState(
        isDetailLoading: false,
        isRecommendationLoading: false,
        isSaved: false,
        movie: testMovieDetail,
        recommendations: <Movie>[],
        saveErrorMessage: null,
        saveMessage: null,
        message: null,
      ));
    when(bloc.stream).thenAnswer((_) => Stream.fromIterable([
          const MovieDetailState(
            isDetailLoading: false,
            isRecommendationLoading: false,
            isSaved: false,
            movie: testMovieDetail,
            recommendations: <Movie>[],
            saveErrorMessage: 'Failed',
            saveMessage: null,
            message: null,
          ),
          const MovieDetailState(
            isDetailLoading: false,
            isRecommendationLoading: false,
            isSaved: false,
            movie: testMovieDetail,
            recommendations: <Movie>[],
            saveErrorMessage: 'Failed',
            saveMessage: null,
            message: null,
          ),
        ]));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}

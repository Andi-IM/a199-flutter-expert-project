part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final bool isDetailLoading;
  final bool isRecommendationLoading;
  final bool isSaved;
  final MovieDetail? movie;
  final List<Movie>? recommendations;
  final String? message;
  final String? saveMessage;
  final String? saveErrorMessage;

  bool get hasError => message != null;

  bool get isSaveError => saveErrorMessage != null;

  const MovieDetailState({
    this.isDetailLoading = false,
    this.isRecommendationLoading = false,
    this.isSaved = false,
    this.movie,
    this.recommendations,
    this.message,
    this.saveMessage,
    this.saveErrorMessage,
  });

  factory MovieDetailState.initialState() => const MovieDetailState(
        isDetailLoading: false,
        isRecommendationLoading: false,
        isSaved: false,
        movie: null,
        recommendations: null,
        message: null,
        saveMessage: null,
        saveErrorMessage: null,
      );

  MovieDetailState copyWith({
    bool? isDetailLoading,
    bool? isRecommendationLoading,
    bool? isSaved,
    MovieDetail? movie,
    List<Movie>? recommendations,
    String? message,
    String? saveMessage,
    String? saveErrorMessage,
    bool clearError = false,
    bool clearMessage = false,
    bool clearSaveError = false,
  }) {
    return MovieDetailState(
      isDetailLoading: isDetailLoading ?? this.isDetailLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      isSaved: isSaved ?? this.isSaved,
      movie: movie ?? this.movie,
      recommendations: recommendations ?? this.recommendations,
      message: clearError ? null : message ?? this.message,
      saveMessage: clearMessage ? null : saveMessage ?? this.saveMessage,
      saveErrorMessage:
          clearSaveError ? null : saveErrorMessage ?? this.saveErrorMessage,
    );
  }

  @override
  String toString() =>
      "State ( detailLoading $isDetailLoading recommendationLoading $isRecommendationLoading, isSaved $isSaved, isMovieNull ${movie == null}, isRecommendationNull ${recommendations == null}, save/error message ${message ?? saveErrorMessage} saveMessage $saveMessage)";

  @override
  List<Object?> get props => [
        isDetailLoading,
        isRecommendationLoading,
        isSaved,
        movie,
        recommendations,
        message,
        saveMessage,
        saveErrorMessage,
      ];
}

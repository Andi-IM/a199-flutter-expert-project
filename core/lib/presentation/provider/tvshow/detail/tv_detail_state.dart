part of 'tv_detail_cubit.dart';

class TvDetailState extends Equatable {
  final bool isDetailLoading;
  final bool isRecommendationLoading;
  final bool isSaved;
  final TvDetail? tv;
  final List<Tv>? recommendations;
  final String? message;
  final String? saveMessage;
  final String? saveErrorMessage;

  bool get hasError => message != null;

  bool get isSaveError => saveErrorMessage != null;

  const TvDetailState({
    this.isDetailLoading = false,
    this.isRecommendationLoading = false,
    this.isSaved = false,
    this.tv,
    this.recommendations,
    this.message,
    this.saveMessage,
    this.saveErrorMessage,
  });

  factory TvDetailState.initialState() => const TvDetailState(
        isDetailLoading: false,
        isRecommendationLoading: false,
        isSaved: false,
        tv: null,
        recommendations: null,
        message: null,
        saveMessage: null,
        saveErrorMessage: null,
      );

  TvDetailState copyWith({
    bool? isDetailLoading,
    bool? isRecommendationLoading,
    bool? isSaved,
    TvDetail? tv,
    List<Tv>? recommendations,
    String? message,
    String? saveMessage,
    String? saveErrorMessage,
    bool clearError = false,
    bool clearMessage = false,
    bool clearSaveError = false,
  }) {
    return TvDetailState(
      isDetailLoading: isDetailLoading ?? this.isDetailLoading,
      isRecommendationLoading:
          isRecommendationLoading ?? this.isRecommendationLoading,
      isSaved: isSaved ?? this.isSaved,
      tv: tv ?? this.tv,
      recommendations: recommendations ?? this.recommendations,
      message: clearError ? null : message ?? this.message,
      saveMessage: clearMessage ? null : saveMessage ?? this.saveMessage,
      saveErrorMessage:
          clearSaveError ? null : saveErrorMessage ?? this.saveErrorMessage,
    );
  }

  @override
  String toString() =>
      "State ( detailLoading $isDetailLoading recommendationLoading $isRecommendationLoading, isSaved $isSaved, isTvNull ${tv == null}, isRecommendationNull ${recommendations == null}, save/error message ${message ?? saveErrorMessage} saveMessage $saveMessage)";

  @override
  List<Object?> get props => [
        isDetailLoading,
        isRecommendationLoading,
        isSaved,
        tv,
        recommendations,
        message,
        saveMessage,
        saveErrorMessage,
      ];
}

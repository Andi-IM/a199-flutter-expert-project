import 'package:core/presentation/provider/tvshow/top_rated/tv_top_rated_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/tv_card_list.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/top-rated-tvshow';

  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvTopRatedCubit>().fetchTopRated();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedCubit, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = state.tvs[index];
                  return TvCard(tvShow);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvTopRatedError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

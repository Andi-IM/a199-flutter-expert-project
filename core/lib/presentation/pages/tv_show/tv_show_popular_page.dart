import 'package:core/presentation/cubit/tv_show/popular/tv_popular_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/tv_card_list.dart';

class PopularTvShowsPage extends StatefulWidget {
  const PopularTvShowsPage({Key? key}) : super(key: key);

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvPopularCubit>().fetchPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Show'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularCubit, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.tvs[index];
                  return TvCard(tv);
                },
                itemCount: state.tvs.length,
              );
            } else if (state is TvPopularError) {
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

import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_show/tv_search_bloc.dart';

class SearchTvShowsPage extends StatelessWidget {
  const SearchTvShowsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<TvSearchBloc>().add(OnTvQueryChanged(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSearchBloc, TvSearchState>(builder: (context, state) {
              if (state is TvSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TvSearchHasData) {
                final result = state.result;
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tvShow = result[index];
                      return TvCard(tvShow);
                    },
                    itemCount: result.length,
                  ),
                );
              } else if (state is TvSearchError) {
                return Expanded(
                  child: Center(
                    key: const Key('error_message'),
                    child: Text(state.message),
                  ),
                );
              } else if (state is TvSearchEmpty) {
                return const Expanded(
                  child: Center(
                    child: Text("Yah Judul yang Kamu cari tidak ditemukan."),
                  ),
                );
              } else {
                return Expanded(
                  child: Container(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}

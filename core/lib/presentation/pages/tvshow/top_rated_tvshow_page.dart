import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../provider/tv_top_rated_notifier.dart';
import '../../widgets/tv_card_list.dart';

class TopRatedTvShowsPage extends StatefulWidget {
  const TopRatedTvShowsPage({Key? key}) : super(key: key);

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvs[index];
                  return TvCard(tvShow);
                },
                itemCount: data.tvs.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}

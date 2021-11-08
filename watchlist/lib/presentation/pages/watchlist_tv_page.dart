import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/presentation/provider/tvshow/tv_watchlist_bloc.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-tv';

  const WatchlistTvShowsPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvShowsPageState createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<TvWatchlistBloc>().add(GetWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() => context.read<TvWatchlistBloc>().add(GetWatchlist());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TvShow Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchlistHasData) {
              final result = state.list;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return TvCard(movie);
                },
                itemCount: result.length,
              );
            } else if (state is TvWatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Watchlist Kamu masih kosong nih."),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

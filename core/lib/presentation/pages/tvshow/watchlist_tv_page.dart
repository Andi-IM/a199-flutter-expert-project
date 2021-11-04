import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/state_enum.dart';
import '../../../utils/utils.dart';
import '../../provider/tvshow/tv_watchlist_notifier.dart';
import '../../widgets/tv_card_list.dart';

class WatchlistTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvShowsPageState createState() => _WatchlistTvShowsPageState();
}

class _WatchlistTvShowsPageState extends State<WatchlistTvShowsPage>
    with RouteAware{
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvWatchlistNotifier>(context, listen: false)
            .fetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<TvWatchlistNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TvShow Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvWatchlistNotifier>(
          builder: (context, data, child) {
            if (data.watchlistState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.watchlistState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.watchlistTvs[index];
                  return TvCard(tv);
                },
                itemCount: data.watchlistTvs.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
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

import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  final Widget content;

  const CustomDrawer({Key? key, required this.content}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  Widget _buildDrawer() {
    return Column(
      children: [
        const UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage('assets/circle-g.png'),
          ),
          accountName: Text('Ditonton'),
          accountEmail: Text('ditonton@dicoding.com'),
        ),
        const ListTile(
          leading: Icon(Icons.movie),
          title: Text('Movies'),
        ),
        ListTile(
          leading: const Icon(Icons.live_tv),
          title: const Text('Tv Shows'),
          onTap: () {
            Navigator.pushNamed(context, tvRoute);
            _animationController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Movie Watchlist'),
          onTap: () {
            Navigator.pushNamed(context, watchlistRoute);
            _animationController.reverse();
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Tv Watchlist'),
          onTap: () {
            Navigator.pushNamed(context, watchlistTvRoute);
            _animationController.reverse();
          },
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, aboutRoute);
            _animationController.reverse();
          },
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
        ),
      ],
    );
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = 255.0 * _animationController.value;
          double scale = 1 - (_animationController.value * 0.3);

          return Stack(
            children: [
              _buildDrawer(),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: widget.content,
              ),
            ],
          );
        },
      ),
    );
  }
}

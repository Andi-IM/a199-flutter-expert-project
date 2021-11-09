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
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://d17ivq9b7rppb3.cloudfront.net/original/jobs/turut_berkontribusi_memajungan_dunia_it_di_indonesia_270619074639.jpeg'),
            ),
            accountName: Text('core'),
            accountEmail: Text('core@dicoding.com'),
          ),
          _buildCard(Icons.movie, 'Movies', () => null),
          _buildCard(Icons.live_tv, 'Tv Shows', () {
            Navigator.pushNamed(context, TV_SHOW_ROUTE);
            _animationController.reverse();
          }),
          _buildCard(Icons.save_alt, 'Movie Watchlist', () {
            Navigator.pushNamed(context, WATCHLIST_ROUTE);
            _animationController.reverse();
          }),
          _buildCard(Icons.save_alt, 'Tv Watchlist', () {
            Navigator.pushNamed(context, WATCHLIST_TV_ROUTE);
            _animationController.reverse();
          }),
          _buildCard(Icons.info_outline, 'About', () {
            Navigator.pushNamed(context, ABOUT_ROUTE);
            _animationController.reverse();
          }),
        ],
      ),
    );
  }

  Widget _buildCard(IconData icon, String title, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
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

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SliverAppBarSnap(),
        ),
      ),
    );
  }
}

class SliverAppBarSnap extends StatefulWidget {
  @override
  _SliverAppBarSnapState createState() => _SliverAppBarSnapState();
}

class _SliverAppBarSnapState extends State<SliverAppBarSnap> {
  final _controller = ScrollController();
  final _refreshController = RefreshController();

  double get maxHeight => 200 + MediaQuery.of(context).padding.top;

  double get minHeight => kToolbarHeight + MediaQuery.of(context).padding.top;

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C0101),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            isEmpty = !isEmpty;
          });
        },
      ),
      body: NotificationListener<ScrollEndNotification>(
        onNotification: (_) {
          _snapAppbar();
          return false;
        },
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () async => _refreshController.refreshCompleted(),
          child: CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            controller: _controller,
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                leading: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                flexibleSpace: Header(
                  maxHeight: maxHeight,
                  minHeight: minHeight,
                ),
                expandedHeight: maxHeight - MediaQuery.of(context).padding.top,
              ),
              if (!isEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildCard(index);
                    },
                    childCount: 20,
                  ),
                )
              else
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      "List is empty",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildCard(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Text("Item $index"),
      ),
    );
  }

  void _snapAppbar() {
    final scrollDistance = maxHeight - minHeight;

    if (_controller.offset > 0 && _controller.offset < scrollDistance) {
      final double snapOffset =
          _controller.offset / scrollDistance > 0.5 ? scrollDistance : 0;

      Future.microtask(() => _controller.animateTo(snapOffset,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn));
    }
  }
}

class Header extends StatelessWidget {
  final double maxHeight;
  final double minHeight;

  const Header({Key? key, required this.maxHeight, required this.minHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(),
            _buildGradient(animation),
            _buildTitle(animation),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    var expandRatio =
        (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Align _buildTitle(Animation<double> animation) {
    return Align(
      alignment: AlignmentTween(
              begin: Alignment(-1.0, 0.75), end: Alignment.bottomLeft)
          .evaluate(animation),
      child: Container(
        padding: EdgeInsetsTween(
                begin: EdgeInsets.only(left: 45), end: EdgeInsets.only(left: 0))
            .evaluate(animation),
        margin: EdgeInsets.only(bottom: 12, left: 12),
        child: Text(
          "THE WEEKEND",
          style: TextStyle(
            fontSize: Tween<double>(begin: 18, end: 36).evaluate(animation),
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Container _buildGradient(Animation<double> animation) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            ColorTween(begin: Colors.black87, end: Colors.black38)
                .evaluate(animation)!
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Image _buildImage() {
    return Image.network(
      "https://www.rollingstone.com/wp-content/uploads/2020/02/TheWeeknd.jpg",
      fit: BoxFit.cover,
    );
  }
}

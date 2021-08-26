import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/common/constants/string_constants.dart';
import 'package:flutter_app/common/injector/injector.dart';
import 'package:flutter_app/data/models/list_item.dart';
import 'package:flutter_app/presentation/bloc/listing_bloc/listing_bloc.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';
import 'package:flutter_app/presentation/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() {
    return _ListingPageState();
  }
}

class _ListingPageState extends State<ListingPage> {
  ListingBloc? _listingBloc;
  final TextEditingController _filterController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  final List<ListItem> _listItems = [];
  final List<ListItem> _filteredListItems = [];
  String _searchText = "";
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBarTitle = const Text(strListingPage);
  bool isUpdating = false;
  bool isLoading = false;
  bool enablePullDown = true;
  double yBtmNavTransValue = 0;

  @override
  void setState(Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _listingBloc = getIt<ListingBloc>();

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _refreshController.requestRefresh());

    _scrollController.addListener(() {
      final bool allowLoad = _scrollController.hasClients &&
          _scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          _searchIcon.icon == Icons.search &&
          _listItems.length >= 20;

      if (allowLoad) {
        setState(() => isLoading = true);
        _listingBloc?.add(FetchListingEvent(listItems: _listItems.toList()));
      }

      final ScrollDirection userScrollDirection =
          _scrollController.position.userScrollDirection;

      if (userScrollDirection == ScrollDirection.reverse &&
          yBtmNavTransValue == 0) {
        setState(() {
          yBtmNavTransValue = 100;
        });
      } else if (userScrollDirection == ScrollDirection.forward &&
          yBtmNavTransValue == 100) {
        setState(() {
          yBtmNavTransValue = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_scrollController.position.pixels >
            _scrollController.position.minScrollExtent + 100) {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: _buildBar(context),
        backgroundColor: colorAppDarkGrey,
        extendBody: true,
        drawer: AppDrawer(),
        // bottomNavigationBar: BottomNavBar(
        //   yTransValue: yBtmNavTransValue,
        // ),
        body: BlocListener<ListingBloc, ListingState>(
          bloc: _listingBloc,
          listener: (context, state) {
            if (state.status == ListingStatus.success) {
              if (state is FetchListingState) {
                final List<ListItem> lists = state.data.lists;
                if (lists.isNotEmpty) {
                  _listItems
                    ..clear()
                    ..addAll(lists);
                  _filteredListItems
                    ..clear()
                    ..addAll(lists);
                }

                if (_refreshController.isRefresh) {
                  _refreshController.refreshCompleted();
                }
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
          child: Stack(children: [
            SmartRefresher(
              controller: _refreshController,
              enablePullDown: enablePullDown,
              onRefresh: () async {
                if (!isLoading) {
                  _listingBloc?.add(FetchListingEvent(
                    status: ListingStatus.initial,
                    listItems: _listItems.toList(),
                  ));
                }
              },
              child: _buildList(context),
            ),
            BottomNavBar(
              yTransValue: yBtmNavTransValue,
            ),
          ]),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  AppBar _buildBar(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        backgroundColor: colorAppDarkGrey,
        centerTitle: true,
        title: _appBarTitle,
        leading: IconButton(icon: _searchIcon, onPressed: _searchPressed));
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredListItems.clear();
      for (int i = 0; i < _listItems.length; i++) {
        if (_listItems[i]
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredListItems.add(_listItems[i]);
        }
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      controller: _scrollController,
      itemCount: _filteredListItems.length + 1,
      itemBuilder: (context, index) {
        if (index == _filteredListItems.length &&
            !_refreshController.isRefresh &&
            _searchIcon.icon == Icons.search) {
          return _buildProgressIndicator();
        } else if (_filteredListItems.isNotEmpty &&
            index < _filteredListItems.length) {
          return _buildListItem(context, _filteredListItems[index]);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(
            color: Color.fromRGBO(64, 75, 96, .9),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, ListItem listItem) {
    return Card(
      key: ValueKey(listItem.name),
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            listItem.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: listItem.distance,
                        style: const TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                    )
                  ],
                ),
              ),
            ],
          ),
//          trailing:
//              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            final double snackBtmMargin =
                yBtmNavTransValue == 100 ? 15 : kBottomNavigationBarHeight + 30;
            final snackBar = SnackBar(
              margin: EdgeInsets.symmetric(
                vertical: snackBtmMargin,
                horizontal: 15,
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(
                  "${listItem.id}: ${listItem.name}\n${listItem.distance}"),
              duration: const Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => UpdateDialog(
                      listingBloc: _listingBloc,
                      listItem: listItem,
                      onListUpdated: (updatedListItem) {
                        setState(() {
                          listItem.name = updatedListItem.name;
                          listItem.distance = updatedListItem.distance;
                        });
                      },
                    ));
          },
        ),
      ),
    );
  }

  _ListingPageState() {
    _filterController.addListener(() {
      if (_filterController.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filterController.text;
        });
      }
    });
  }

  void _resetRecords() {
    _filteredListItems.clear();
    for (final ListItem listItem in _listItems) {
      _filteredListItems.add(listItem);
    }
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        enablePullDown = false;
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filterController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            fillColor: Colors.white,
            hintText: 'Search by name',
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        enablePullDown = true;
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text(strListingPage);
        _filterController.clear();
      }
    });
  }

  @override
  void dispose() {
    _listingBloc?.close();
    _filterController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class UpdateDialog extends StatefulWidget {
  final ListingBloc? listingBloc;
  final ListItem listItem;
  final ValueChanged<ListItem> onListUpdated;

  const UpdateDialog(
      {Key? key,
      required this.listingBloc,
      required this.listItem,
      required this.onListUpdated})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();

  bool isUpdating = false;

  @override
  void setState(Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.listItem.name;
    _distanceController.text = widget.listItem.distance;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      backgroundColor: colorAppGrey2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'List Name',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
            ),
            TextField(
              controller: _distanceController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'List Distance',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30.0)),
            BlocListener<ListingBloc, ListingState>(
              bloc: widget.listingBloc,
              listener: (context, state) {
                if (state.status == ListingStatus.success) {
                  if (state is UpdateListingState) {
                    isUpdating = false;
                    final ListItem? item = state.data;
                    if (item != null) {
                      widget.onListUpdated(item);
                    }
                    AutoRouter.of(context).pop();
                  }
                }
              },
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(colorAppDarkGrey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                ),
                onPressed: () {
                  widget.listItem.name = _nameController.text;
                  widget.listItem.distance = _distanceController.text;
                  setState(() {
                    isUpdating = true;
                  });
                  widget.listingBloc
                      ?.add(UpdateListingEvent(listItem: widget.listItem));
                  // _updateList(widget.listItem);
                },
                child: setUpButtonChild(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (!isUpdating) {
      return const Text(
        'Update',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      );
    } else {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  // void _updateList(ListItem listItem) async {
  //   try {
  //     bool result = await ApiClient.updateList(listItem);
  //     if (result) {
  //       isUpdating = false;
  //       widget.onListUpdated(listItem);
  //       AutoRouter.of(context).pop();
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _distanceController.dispose();
    super.dispose();
  }
}

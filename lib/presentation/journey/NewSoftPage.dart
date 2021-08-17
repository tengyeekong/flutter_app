import 'package:flutter/material.dart';
import 'package:flutter_app/common/Constants.dart';
import 'package:flutter_app/common/injector/injector.dart';
import 'package:flutter_app/data/models/ListItem.dart';
import 'package:flutter_app/data/models/Listing.dart';
import 'package:flutter_app/presentation/bloc/listing_bloc/listing_bloc.dart';
import 'package:flutter_app/presentation/widgets/AppDrawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewSoftPage extends StatefulWidget {
  @override
  _NewSoftPageState createState() {
    return _NewSoftPageState();
  }
}

class _NewSoftPageState extends State<NewSoftPage> {
  ListingBloc? _listingBloc;
  final TextEditingController _filterController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  List<ListItem> _listItems = [];
  List<ListItem> _filteredListItems = [];
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text(newSoftTitle);
  bool isUpdating = false;
  bool isLoading = false;
  bool enablePullDown = true;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _listingBloc = Injector.resolve<ListingBloc>();

    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => _refreshController.requestRefresh());

    _scrollController.addListener(() {
      bool allowLoad = _scrollController.hasClients &&
          _scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          this._searchIcon.icon == Icons.search;

      if (allowLoad) {
        setState(() => isLoading = true);
        _listingBloc?.add(FetchListingEvent(listItems: _listItems.toList()));
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
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn);
          return false;
        } else
          return true;
      },
      child: Scaffold(
        appBar: _buildBar(context),
        backgroundColor: appDarkGreyColor,
        drawer: AppDrawer(),
//        bottomNavigationBar: BottomNavBar(),
        body: BlocListener<ListingBloc, ListingState>(
          bloc: _listingBloc,
          listener: (context, state) {
            if (state.status == ListingStatus.success) {
              if (state is FetchListingState) {
                Listing listing = state.data;
                _listItems
                  ..clear()
                  ..addAll(listing.lists);
                _filteredListItems
                  ..clear()
                  ..addAll(listing.lists);

                if (_refreshController.isRefresh) {
                  _refreshController.refreshCompleted();
                }
                setState(() {
                  isLoading = false;
                });
              }
            }
          },
          child: SmartRefresher(
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
              child: _buildList(context)),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  AppBar _buildBar(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        backgroundColor: appDarkGreyColor,
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
            this._searchIcon.icon == Icons.search) {
          return _buildProgressIndicator();
        } else if (_filteredListItems.length > 0 &&
            index < _filteredListItems.length) {
          return _buildListItem(context, _filteredListItems[index]);
        } else
          return Container();
      },
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 14.0, 8.0, 8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(
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
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            listItem.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                        style: TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                      softWrap: true,
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
            final snackBar = SnackBar(
              content: Text(listItem.id +
                  ": " +
                  listItem.name +
                  "\n" +
                  listItem.distance),
              duration: Duration(seconds: 2),
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

  _NewSoftPageState() {
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
    this._filteredListItems.clear();
    for (ListItem listItem in _listItems) {
      this._filteredListItems.add(listItem);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        enablePullDown = false;
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filterController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            fillColor: Colors.white,
            hintText: 'Search by name',
            hintStyle: TextStyle(color: Colors.white),
          ),
        );
      } else {
        enablePullDown = true;
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text(newSoftTitle);
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
  void setState(fn) {
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
      backgroundColor: appGreyColor2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
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
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
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
            Padding(padding: EdgeInsets.only(top: 30.0)),
            BlocListener<ListingBloc, ListingState>(
              bloc: widget.listingBloc,
              listener: (context, state) {
                if (state.status == ListingStatus.success) {
                  if (state is UpdateListingState) {
                    isUpdating = false;
                    ListItem? item = state.data;
                    if (item != null) {
                      widget.onListUpdated(item);
                    }
                    Navigator.of(context).pop();
                  }
                }
              },
              child: TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 40)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(appDarkGreyColor),
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
      return Text(
        'Update',
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      );
    } else {
      return CircularProgressIndicator(
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
  //       Navigator.of(context).pop();
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

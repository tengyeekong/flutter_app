import 'package:flutter/material.dart';
import 'package:flutter_app/api/Api.dart';
import 'package:flutter_app/helpers/Constants.dart';
import 'package:flutter_app/models/ListItem.dart';
import 'package:flutter_app/models/Listing.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../AppDrawer.dart';

class NewSoftPage extends StatefulWidget {
  @override
  _NewSoftPageState createState() {
    return _NewSoftPageState();
  }
}

class _NewSoftPageState extends State<NewSoftPage> {
  final TextEditingController _filterController = TextEditingController();
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  Listing _lists = Listing();
  Listing _filteredLists = Listing();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);
  Widget _appBarTitle = Text(newSoftTitle);
  bool isUpdating = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _lists.lists = List();
    _filteredLists.lists = List();

    _getLists(false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshController.requestRefresh());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading) {
        _getLists(false);
      }
    });
  }

  void _getLists(bool isRefresh) async {
    try {
      setState(() {
        isLoading = true;
      });

      Listing lists = await Api.getListing();
      if (lists != null) {
        if (isRefresh) {
          _lists.lists.clear();
          _filteredLists.lists.clear();
        }
        setState(() {
          for (ListItem listItem in lists.lists) {
            _lists.lists.add(listItem);
            _filteredLists.lists.add(listItem);
          }
          isLoading = false;
        });
      }
      _refreshController.refreshCompleted();
    } catch (e) {
      print(e);
    }
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
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: () async {
            _getLists(true);
          },
          child: _buildList(context),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
        elevation: 0.1,
        backgroundColor: appDarkGreyColor,
        centerTitle: true,
        title: _appBarTitle,
        leading: IconButton(icon: _searchIcon, onPressed: _searchPressed));
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isNotEmpty) {
      _filteredLists.lists = List();
      for (int i = 0; i < _lists.lists.length; i++) {
        if (_lists.lists[i].name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredLists.lists.add(_lists.lists[i]);
        }
      }
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      controller: _scrollController,
      itemCount: _filteredLists.lists.length + 1,
      itemBuilder: (context, index) {
        if (index == _filteredLists.lists.length &&
            !_refreshController.isRefresh) {
          return _buildProgressIndicator();
        } else if (_filteredLists.lists.length > 0) {
          return _buildListItem(context, _filteredLists.lists[index]);
        } else {
          return Center();
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
          child: CircularProgressIndicator(
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
                  ]))
            ],
          ),
//          trailing:
//              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Scaffold.of(context).hideCurrentSnackBar();
            final snackBar = SnackBar(
              content: Text(listItem.id +
                  ": " +
                  listItem.name +
                  "\n" +
                  listItem.distance),
              duration: Duration(seconds: 2),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => UpdateDialog(
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
    this._filteredLists.lists = List();
    for (ListItem listItem in _lists.lists) {
      this._filteredLists.lists.add(listItem);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
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
        this._searchIcon = Icon(Icons.search);
        this._appBarTitle = Text(newSoftTitle);
        _filterController.clear();
      }
    });
  }

  @override
  void dispose() {
    _filterController.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class UpdateDialog extends StatefulWidget {
  final ListItem listItem;
  final ValueChanged<ListItem> onListUpdated;

  const UpdateDialog({Key key, this.listItem, this.onListUpdated})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();

  bool isUpdating = false;

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
            FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              color: appDarkGreyColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                widget.listItem.name = _nameController.text;
                widget.listItem.distance = _distanceController.text;
                setState(() {
                  isUpdating = true;
                });
                _updateList(widget.listItem);
              },
              child: setUpButtonChild(),
            )
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

  void _updateList(ListItem listItem) async {
    try {
      bool result = await Api.updateList(listItem);
      if (result) {
        isUpdating = false;
        widget.onListUpdated(listItem);
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _distanceController.dispose();
    super.dispose();
  }
}

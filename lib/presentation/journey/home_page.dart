import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants.dart';
import 'package:flutter_app/data/models/record.dart';
import 'package:flutter_app/data/models/record_list.dart';
import 'package:flutter_app/data/models/record_service.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = TextEditingController();

  RecordList _records = RecordList(records: []);
  RecordList _filteredRecords = RecordList(records: []);

  String _searchText = "";

  Icon _searchIcon = Icon(Icons.search);

  Widget _appBarTitle = Text(appTitle);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _getRecords();
  }

  void _getRecords() async {
    RecordList records = await RecordService().loadRecords();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        for (Record record in records.records) {
          _records.records.add(record);
          _filteredRecords.records.add(record);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appDarkGreyColor,
      drawer: AppDrawer(),
      body: _buildList(context),
      resizeToAvoidBottomInset: false,
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
      _filteredRecords.records = [];
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            _records.records[i].address
                .toLowerCase()
                .contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    if (_filteredRecords.records.length == 0) {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white30,
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 20.0),
        itemCount: _filteredRecords.records.length,
        itemBuilder: (context, index) {
          return _buildListItem(context, _filteredRecords.records[index]);
        },
      );

//      return ListView(
//        padding: const EdgeInsets.only(top: 20.0),
//        children: this._filteredRecords.records.map((data) =>
//            _buildListItem(context, data)).toList(),
//      );
    }
  }

  Widget _buildListItem(BuildContext context, Record record) {
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: Hero(
              tag: "avatar_" + record.name,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(record.photo),
              ),
            ),
          ),
          title: Text(
            record.name,
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
                        text: record.address,
                        style: TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              detailsPageTag,
              (route) => route.isCurrent
                  ? route.settings.name == detailsPageTag
                      ? false
                      : true
                  : true,
              arguments: record,
            );

//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => DetailPage(record: record)));
          },
        ),
      ),
    );
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords() {
    this._filteredRecords.records = [];
    for (Record record in _records.records) {
      this._filteredRecords.records.add(record);
    }
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close);
        this._appBarTitle = TextField(
          controller: _filter,
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
        this._appBarTitle = Text(appTitle);
        _filter.clear();
      }
    });
  }
}

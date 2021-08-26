import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/common/constants/router_constants.dart';
import 'package:flutter_app/common/constants/string_constants.dart';
import 'package:flutter_app/data/models/record.dart';
import 'package:flutter_app/data/models/record_list.dart';
import 'package:flutter_app/data/models/record_service.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';

import '../routes.gr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = TextEditingController();

  final RecordList _records = RecordList(records: []);
  final RecordList _filteredRecords = RecordList(records: []);

  String _searchText = "";

  Icon _searchIcon = const Icon(Icons.search);

  Widget _appBarTitle = const Text(strAppTitle);

  @override
  void setState(Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();

    _getRecords();
  }

  Future _getRecords() async {
    final RecordList records = await RecordService().loadRecords();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        for (final Record record in records.records) {
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
      backgroundColor: colorAppDarkGrey,
      drawer: AppDrawer(),
      body: _buildList(context),
      resizeToAvoidBottomInset: false,
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

    if (_filteredRecords.records.isEmpty) {
      return const Center(
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
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 15.0),
            decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white24))),
            child: Hero(
              tag: "avatar_${record.name}",
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(record.photo),
              ),
            ),
          ),
          title: Text(
            record.name,
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
                        text: record.address,
                        style: const TextStyle(color: Colors.white),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.white,
            size: 30.0,
          ),
          onTap: () {
            AutoRouter.of(context).pushAndPopUntil(
              DetailRoute(record: record),
              predicate: (route) {
                if (route.isCurrent &&
                    route.settings.name == RouteName.detailsPage) {
                  return false;
                } else {
                  return true;
                }
              },
            );
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
    _filteredRecords.records = [];
    for (final Record record in _records.records) {
      _filteredRecords.records.add(record);
    }
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);
        _appBarTitle = TextField(
          controller: _filter,
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
        _searchIcon = const Icon(Icons.search);
        _appBarTitle = const Text(strAppTitle);
        _filter.clear();
      }
    });
  }
}

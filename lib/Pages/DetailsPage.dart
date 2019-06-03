import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/URLLauncher.dart';
import 'package:flutter_app/models/Record.dart';

import '../AppDrawer.dart';

// 1
class DetailPage extends StatelessWidget {
  final Record record;
  // 2
  DetailPage({this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(record.name),
        ),
        drawer: AppDrawer(),
        body: ListView(
            children: <Widget>[
              Hero(
                tag: "avatar_" + record.name,
                child: Image.network(
                    record.photo
                ),
              ),
              // 3
              GestureDetector(
                  onTap: () {
                    URLLauncher().launchURL(record.url);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      children: [
                        // First child in the Row for the name and the
                        // Release date information.
                        Expanded(
                          // Name and Address are in the same column
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Code to create the view for name.
                              Container(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Name: " + record.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Code to create the view for address.
                              Text(
                                "Address: " + record.address,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Icon to indicate the phone number.
                        Icon(
                          Icons.phone,
                          color: Colors.red[500],
                        ),
                        Text(' ${record.contact}'),
                      ],
                    ),
                  )
              ),
            ]
        )
    );
  }
}
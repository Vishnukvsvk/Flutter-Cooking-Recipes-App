import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_channel/searchservice.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['title'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val) {
              initiateSearch(val);
            },
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search by name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0))),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
            children: tempSearchStore.map((element) {
          return buildResultCard(element);
        }).toList())
      ])),
    );
  }
}

Widget buildResultCard(data) {
  return 
     Column(
      children: <Widget>[
        FlipCard(
          direction: FlipDirection.HORIZONTAL,
          front: Container(
            width: 300,
            height: 200.0,
            child: Image.network(data['image'], fit: BoxFit.fill),
          ),
          back: Container(
            width: 300,
            height: 200.0,
            color: Colors.white,
            child: Text("Recipe"),
          ),
        ),
        SizedBox(height: 10.0),
        InkWell(
          child: Container(
            width: 200,
            height: 20.0,
            child: Center(
                child: Text(
              data['title'],
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey),
            )),
          ),
          onTap: () => launch(data['url']),
        ),
      ],
    );
}

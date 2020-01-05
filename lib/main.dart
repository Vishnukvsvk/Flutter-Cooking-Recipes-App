//import 'package:firebase_admob/firebase_admob.dart';
import 'package:cooking_channel/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flip_card/flip_card.dart';
import 'Channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyHomePage(),
      // theme: ThemeData(
      //   primarySwatch: Colors.brown,
      // ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    
    // FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6313643779593552~8721139498").then((response){
    //     myBanner..load()..show();
    //});
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchBar()));},
            ),
        ],
        title: Text(
          "Aha Emi Ruchi",
          style: TextStyle(color: Colors.orange),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance.collection('post').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading...");
              } else {
                return Expanded(
                                  child: SizedBox(
                    height: 200,
                                    child: ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot mypost =
                            snapshot.data.documents[index]; //getting the document
                        return Stack(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              width: MediaQuery.of(context).size.width,
                              height: 280.0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        FlipCard(
                                          direction: FlipDirection.HORIZONTAL,
                                          front: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 200.0,
                                            child: Image.network('${mypost['image']}',
                                                fit: BoxFit.fill),
                                          ),
                                          back: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 200.0,
                                            color: Colors.white,
                                            child: Text("Recipe"),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        InkWell(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 20.0,
                                            child: Center(
                                                child: Text(
                                              '${mypost['title']}',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blueGrey),
                                            )),
                                          ),
                                          onTap: () => launch('${mypost['url']}'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Aishwarya's",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 2),
                    CircleAvatar(
                      backgroundImage:
                          ExactAssetImage("assets/images/iconsym.png"),
                      minRadius: 50.0,
                      maxRadius: 60.0,
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                Colors.yellow[200],
                Colors.yellowAccent,
              ])),
            ),
            CustomTile(Icons.arrow_forward_ios, 'Youtube Channel', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChannelInfo()));
            }),
            
          ],
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.orangeAccent,
        child: Container(
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(icon),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              //Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}





import 'package:flutter/material.dart';

class ChannelInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
                  child: Column(children: <Widget>[
              Image.asset("assets/images/meetome.png"),
              Text("Hai friends!",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              SizedBox(height: 10.0),
              Text("Naku vachina vantalu meeto panchukotaniki vachesanu 'Mee tho mee Vantalakka' ga. Navi vegetarian vantalu.Avi kooda easy ga intlo available ga vunde ingredients tho  chestanu. New ga vantalu chese vallaki easy ga artham ayyela vuntai. So tappaka choodandi. Emaina suggestions vunte ivvandi,inka better ga try chestanu.",style: TextStyle(fontSize: 16.0,color: Colors.black)),
              Text("I make vegetarian recipies which are easy to cook and good to eat.Please watch my videos for delicious recipies .Thankyou",style: TextStyle(fontSize: 16.0,color: Colors.black)),
              SizedBox(height: 10.0),
              Center(child: Text("HAPPY AND HEALTHY COOKING😊😊😊",style: TextStyle(fontSize: 19.0,color: Colors.blue,fontWeight:FontWeight.bold)))
            ],),
        ),
        ),
    );
  }
}


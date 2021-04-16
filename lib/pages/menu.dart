import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Motorcyclist’s Behavioural Performance System"),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                    onTap: () {
                      print("something");
                    },
                    child: Card(
                      color: HexColor('#CAE7B9'),
                      borderOnForeground: true,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("CHECK IN", style: TextStyle(fontSize: 25)),
                      ),
                    ))),
          ],
        ));
  }
}
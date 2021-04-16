import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocode/geocode.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TableContent(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null,
        label: Text("Push Data Online"),
      ),
    );
  }
}

class TableContent extends StatefulWidget {
  @override
  _TableContentState createState() => _TableContentState();
}

class _TableContentState extends State<TableContent> {
  @override
  Widget build(BuildContext context) {
    CollectionReference rider = FirebaseFirestore.instance.collection("rider");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
            flex: 1,
            child: Card(
              child: Center(
                  child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('club_details')
                    .doc()
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return new ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        title: new Text(
                          "Ahmad Siraj MY",
                          //textAlign: TextAlign.center,
                        ),
                        subtitle: Text(
                          "Demak D7\n\nTurn Signal to Junction Ratio: 0%",
                          // textAlign: TextAlign.center,
                        ),
                        trailing: ElevatedButton(
                          child: Text('Rider Profile'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                },
              )),
            )),
        Flexible(
          flex: 3,
          child: StreamBuilder<QuerySnapshot>(
            stream: rider.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return new Container(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(columns: [
                        DataColumn(label: Text('Junction')),
                        DataColumn(label: Text('Speed')),
                        DataColumn(label: Text('Turn Signal'))
                      ], rows: _createRows(snapshot.data)),
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      GeoPoint geoPoint = document.data()['junction'];
      double lat = geoPoint.latitude;
      double lng = geoPoint.longitude;

      return new DataRow(cells: [
        DataCell(Text(
          "$lat,$lng",
        )),
        DataCell(Text(
          document.data()['speed'].toString(),
        )),
        DataCell(Text(
          document.data()['turn_signal'].toString(),
        )),
      ]);
    }).toList();

    return newList;
  }
}

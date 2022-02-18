import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pickandgo/databasehelper.dart';
//import 'package:pickandgo/screens/pickupdriver/widgets/navigationdrawerpickupdriver.dart';

class OperationalCenterDriverRequests extends StatefulWidget {
  const OperationalCenterDriverRequests({Key? key}) : super(key: key);

  @override
  State<OperationalCenterDriverRequests> createState() =>
      _OperationalCenterDriverRequestsState();
}

class _OperationalCenterDriverRequestsState
    extends State<OperationalCenterDriverRequests> {
  final String id = 'fvU81neFWYdVjmAkicPdgzIxMuy1';
  late bool driveroccupied;
  String? operationalcenterid = 'jtY3njjcIlF480cCBe9W';

  bool _isLoading = true;

  _getDriverOccupuedStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        driveroccupied = documentSnapshot['driveroccupied'];
      } else {
        print("The user document does not exist");
      }
    });
  }

  @override
  void initState() {
    //getCordFromAdd();
    super.initState();
    _getDriverOccupuedStatus();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _db = DatabaseHelper();
    return Scaffold(
      //drawer: NavigationDrawerWidget(
      //id: widget.id,
      //driveroccupied: widget.driveroccupied,
      //operationalcenterid: widget.operationalcenterid,
      //),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('PickandGO - Op-Center Delivery'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            (_isLoading == true)
                ? const Padding(
                    padding: const EdgeInsets.only(top: 350.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('uid', isEqualTo: id)
                          .where('driveroccupied', isEqualTo: false)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              var x = [];
                              x = snapshot.data?.docs[index]['packages']
                                  .toList();
                              return (x.length != 0)
                                  ? Card(
                                      child: ListTile(
                                        title: Row(
                                          children: <Widget>[
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.card_giftcard_outlined),
                                            ),
                                            Flexible(
                                              child: Text(
                                                snapshot
                                                    .data!.docs[index]['uid']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right),
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(id)
                                                    .get()
                                                    .then((DocumentSnapshot
                                                        documentSnapshot) {
                                                  if (documentSnapshot.exists) {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(id)
                                                        .set({
                                                      "driveroccupied": true,
                                                    }, SetOptions(merge: true));
                                                    print(
                                                        "Driver document updated successfully");
                                                  } else {
                                                    print(
                                                        "The user document does not exist ");
                                                  }
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Center(child: Text("No Requests"));
                            });
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

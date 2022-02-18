//import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OperationalCenterDriverPackagesDropped extends StatefulWidget {
  const OperationalCenterDriverPackagesDropped({Key? key}) : super(key: key);

  @override
  State<OperationalCenterDriverPackagesDropped> createState() =>
      _OperationalCenterDriverPackagesDroppedState();
}

class _OperationalCenterDriverPackagesDroppedState
    extends State<OperationalCenterDriverPackagesDropped> {
  var driverId = 'fvU81neFWYdVjmAkicPdgzIxMuy1';
  var toOperationalCenterId;

  _updatePackagesDropped() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(driverId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        toOperationalCenterId = documentSnapshot['toOperationalCenterId'];
      } else {
        print("The user document does not exist");
      }
    });

    await FirebaseFirestore.instance
        .collection('package')
        .where('operationalCenterDriverId', isEqualTo: driverId)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                FirebaseFirestore.instance
                    .collection('package')
                    .doc(doc['packageid'].toString())
                    .set({
                  "toOperationalCenterId": toOperationalCenterId,
                }, SetOptions(merge: true));
              })
            });

    await FirebaseFirestore.instance.collection('users').doc(driverId).update(
        {'packages': [], 'driveroccupied': false, 'toOperationalCenterId': ''});

    print("All operations done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Drop All Packages"),
        backgroundColor: Colors.black,
      ),
      body: Align(
        alignment: Alignment.center,
        child: MaterialButton(
            onPressed: () {
              _updatePackagesDropped();
            },
            minWidth: 160,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            color: Colors.black,
            child: const Text(
              'Packages Delivered',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}

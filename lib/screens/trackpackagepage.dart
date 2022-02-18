import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pickandgo/screens/receivertracking.dart';
import 'package:pickandgo/services/routingpage.dart';

import '../../../databasehelper.dart';

class TrackPackage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _TrackPackageState createState() => _TrackPackageState();
}

class _TrackPackageState extends State<TrackPackage> {
  final _auth = FirebaseAuth.instance;

  DatabaseHelper _db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final controllers = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Pick Up Request'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => RoutePage(),
                  ),
                );
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Center(
                child: Image(
                  width: 200,
                  height: 200,
                  image: AssetImage('assets/trackpackage.png'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pick & go',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Text(
                "Pic & Go is Sri Lanka's no 01 unique delivery service. We offering the cheapest, quickest and safest service in door to door delivery.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            // const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "Enter tracking code",
                    fillColor: Colors.white70),
                controller: controllers,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 380,
              height: 50,
              color: Colors.white,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.black)))),
                onPressed: () {


                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ReceiverTracking(
                              controllers.text)));




                },
                child: const Text(
                  'Track',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

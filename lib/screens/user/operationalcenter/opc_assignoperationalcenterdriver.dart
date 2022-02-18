import 'package:flutter/material.dart';
import 'package:pickandgo/screens/user/operationalcenter/opc_addpackageoperationalcenterdriver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:pickandgo/screens/operationalcenter/widgets/navigationdrawercenter.dart';
//import '../../databasehelper.dart';
//import 'opc_addpackagesdropoffdriver.dart';

class AssignOperationalCenterDriver extends StatefulWidget {
  const AssignOperationalCenterDriver({Key? key}) : super(key: key);

  @override
  State<AssignOperationalCenterDriver> createState() =>
      _AssignOperationalCenterDriverState();
}

class _AssignOperationalCenterDriverState
    extends State<AssignOperationalCenterDriver> {
  var operationalCenterId = 'jtY3njjcIlF480cCBe9W';
  var uid = 'gq9TLQoVgzaI4CXdSJoHXDg1oY62';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      //drawer:
      //  NavigationDrawerWidgetCenter(uid, operationalCenterId),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('PickandGO - Operational Center'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.black87,
                  size: 28,
                ),
                SizedBox(
                  width: 6.0,
                ),
                Text(
                  'Assign Driver',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('role', isEqualTo: "OperationalCenterDriver")
                  .where('operationalcenterid', isEqualTo: operationalCenterId)
                  .where('driveroccupied', isEqualTo: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.account_circle, size: 32),
                              ),
                              Flexible(
                                child: Text(
                                    snapshot.data!.docs[index]['name']
                                        .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                          subtitle: Text(
                              "Driver Id: " +
                                  snapshot.data!.docs[index]['uid'].toString(),
                              style: TextStyle(fontSize: 13.7)),
                          trailing: Column(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          AddPackagesOperationalCenterDriver(
                                              uid,
                                              operationalCenterId,
                                              snapshot.data!.docs[index]['uid']
                                                  .toString())));
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}

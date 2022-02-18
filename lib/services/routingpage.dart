import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pickandgo/models/model.dart';
import 'package:pickandgo/screens/dropoffdriver/dropoffdriverdashboard.dart';
import 'package:pickandgo/screens/operationalcenter/opc_dashboard.dart';
import 'package:pickandgo/screens/operationalcenterdriver/opcdriver_dashboard.dart';
import 'package:pickandgo/screens/pickupdriver/pickupdriverdashboard.dart';
import 'package:pickandgo/screens/user/homepage.dart';

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  _RoutePageState();

  @override
  Widget build(BuildContext context) {
    return contro();
  }
}

class contro extends StatefulWidget {
  contro();

  @override
  _controState createState() => _controState();
}

class _controState extends State<contro> {
  _controState();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var role;
  var emaill;
  var id;
  var driveroccupied;
  var operationalcenterid;

  @override
  void initState() {
    if (user?.uid != null) {
      super.initState();
      FirebaseFirestore.instance
          .collection("users") //.where('uid', isEqualTo: user!.uid)
          .doc(user?.uid)
          .get()
          .then((value) {
        this.loggedInUser = UserModel.fromMap(value.data());
      }).whenComplete(() {
        CircularProgressIndicator();
        if (this.mounted) {
          setState(() {
            emaill = loggedInUser.email.toString();
            role = loggedInUser.role.toString();
            id = loggedInUser.uid.toString();
            driveroccupied = loggedInUser.driveroccupied;
            operationalcenterid = loggedInUser.operationalcenterid.toString();
          });
        }
      });
    }
  }

  routing() {
    return (role == "User")
        ? Homepage(
            id: loggedInUser.uid.toString(),
            name: loggedInUser.name.toString(),
            email: loggedInUser.email.toString(),
            mobile: loggedInUser.mobile.toString(),
            address: loggedInUser.address.toString(),
            role: loggedInUser.role.toString(),
          )
        : (role == "OperationalCenter")
            ? Dashboard(
                loggedInUser.uid.toString(),
                loggedInUser.operationalcenterid.toString(),
              )
            : (role == "Driver" && loggedInUser.status == "Active")
                ? PickupDriverDashboard(
                    operationalcenterid:
                        loggedInUser.operationalcenterid.toString(),
                    driveroccupied: loggedInUser.driveroccupied,
                    id: loggedInUser.uid.toString(),
                  )
                : (role == "Driver" && loggedInUser.status == "Blocked")
                    ? Text("Account Blocked. Contact Admin")
                    : (role == "DropoffDriver" &&
                            loggedInUser.status == "Active")
                        ? DropoffDriverDashboard(
                            id: loggedInUser.uid.toString(),
                            operationalcenterid:
                                loggedInUser.operationalcenterid.toString(),
                            driveroccupied: loggedInUser.driveroccupied,
                          )
                        : (role == "DropoffDriver" &&
                                loggedInUser.status == "Blocked")
                            ? Text("Account Blocked. Contact Admin")
                            : (role == "OperationalCenterDriver" &&
                                    loggedInUser.status == "Active")
                                ? OPCDriverDashboard(
                                    id: loggedInUser.uid.toString(),
                                    operationalcenterid: loggedInUser
                                        .operationalcenterid
                                        .toString(),
                                    driveroccupied: loggedInUser.driveroccupied,
                                  )
                                : (role == "OperationalCenterDriver" &&
                                        loggedInUser.status == "Blocked")
                                    ? Text("Account Blocked. Contact Admin")
                                    : Text("Invalid Details");
  }

  @override
  Widget build(BuildContext context) {
    CircularProgressIndicator();
    return routing();
  }
}

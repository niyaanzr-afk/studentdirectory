import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addstudent(
  String name,
  String regno,
  String course,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection("studentdata").add({
      "NAME": name,
      "REGISTER NO": regno,
      "COURSE": course,
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student added successfully")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

Stream<QuerySnapshot> getstudents() {
  return FirebaseFirestore.instance.collection("studentdata").snapshots();
}

Future<void> deletestudent(String id, BuildContext context) async {
  try {
    await FirebaseFirestore.instance.collection("studentdata").doc(id).delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("student deleted successfully")));
  } catch (e) {ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));}
}

Future<void> updatestudent(
  String name,
  String regno,
  String course,
  String id,
  BuildContext context,
) async {
  try {
    await FirebaseFirestore.instance.collection("studentdata").doc(id).update({
      "NAME": name,
      "REGISTER NO": regno,
      "COURSE": course,
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Student updated successfully")));
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}

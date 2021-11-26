import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String userId;
  final String displayName;
  final String email;
  final String department;
  final String stage;
  final String timestamp;
  final String vaccine;

  Users(
      {required this.userId,
      required this.displayName,
      required this.email,
      required this.department,
      required this.stage,
      required this.timestamp,
      required this.vaccine});

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      userId: doc['userId'],
      displayName: doc['displayName'],
      email: doc['email'],
      department: doc['department'],
      stage: doc['stage'],
      timestamp: doc['timestamp'].toString(),
      vaccine: doc['vaccine']
    );
  }
}
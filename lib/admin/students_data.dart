import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_check/admin/student_details.dart';
import 'package:students_check/components/progress.dart';

class StudentsData extends StatefulWidget {
  static const String id = 'students_data';
  const StudentsData({Key? key}) : super(key: key);

  @override
  _StudentsDataState createState() => _StudentsDataState();
}

class _StudentsDataState extends State<StudentsData> {
  CollectionReference myUsers = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: myUsers.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.all(7.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentDetails(
                            // title: data[index]['title'],
                            // details: data[index]['details'],
                            // address: data[index]['address'],
                            // phoneNumber: data[index]['phoneNumber'],
                          )));
                        },
                        title: Text(data[index]['displayName'], style: const TextStyle(fontSize: 20), textDirection: TextDirection.rtl),
                        subtitle: Text(data[index]['vaccine'], textDirection: TextDirection.rtl),
                        leading: Icon(Icons.arrow_back_ios_new_rounded,size: 40, color: Theme.of(context).primaryColor),
                      ),
                    );
                  }
              );
            }
        ),

      ),
    );
  }
}

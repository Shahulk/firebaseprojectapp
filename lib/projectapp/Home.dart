import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference donor = FirebaseFirestore.instance.collection(
      'donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation App"),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add, size: 30,),

      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: StreamBuilder(
          stream: donor.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot donorsnap = snapshot.data
                        .docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey.shade300,blurRadius: 10,spreadRadius: 15),
                          ],

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 30,
                                  child: Text(donorsnap['group'],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(donorsnap['Name'],style: TextStyle(fontSize: 18,color: Colors.black),),
                                Text(donorsnap['Phone'].toString(),style: TextStyle(fontSize: 18,color: Colors.black),),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(onPressed: (){}, icon:Icon(Icons.edit) ,iconSize: 30,color: Colors.blue,),
                                IconButton(onPressed: (){}, icon:Icon(Icons.delete),iconSize: 30,color: Colors.red, ),
                              ],
                            )

                          ],
                        ),
                      ),
                    );
                  });
            }
            return Container();
          }
      ),
    );
  }
}

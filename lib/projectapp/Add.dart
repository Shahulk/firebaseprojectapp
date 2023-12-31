import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({Key? key}) : super(key: key);

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  final bloodGroup = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ? selectedGroup;
  final CollectionReference donor = FirebaseFirestore.instance.collection(
      'donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void addDonor() {
    final data = {'Name': donorName.text, 'Phone':donorPhone.text, 'Group':selectedGroup};
    donor.add(data);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Users"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),label: Text("Donor Name")
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),label: Text("Phone Number")
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(label: Text('Selected Blood Group')),
                  items: bloodGroup.map((e) => DropdownMenuItem(child: Text(e),
              value: e,)).toList(),
                  onChanged: (VAL){
                selectedGroup = VAL;
                  }),
            ),
            ElevatedButton(onPressed: (){
              addDonor();
              Navigator.pop(context);
            },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                child: Text('Submit',style: TextStyle(fontSize: 20),))
          ],
        ),
      ),
    );
  }
}

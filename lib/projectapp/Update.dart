import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({Key? key}) : super(key: key);

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroup = ['A+','A-','B+','B-','O+','O-','AB+','AB-'];
  String ? selectedGroup;
  final CollectionReference donor = FirebaseFirestore.instance.collection(
      'donor');
  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();
  void updateDonor(docId){
    final data = {
      'Name':donorName.text,
      'Phone':donorPhone.text,
      'Group': selectedGroup
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final argmt = ModalRoute.of(context)?.settings.arguments as Map;
    donorName.text = argmt['Name'];
    donorPhone.text = argmt['Phone'];
    selectedGroup = argmt['Group'];
    final docId = argmt['id'];
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
                value: selectedGroup,
                  decoration: InputDecoration(label: Text('Selected Blood Group')),
                  items: bloodGroup.map((e) => DropdownMenuItem(child: Text(e),
                    value: e,)).toList(),
                  onChanged: (VAL){
                    selectedGroup = VAL;
                  }),
            ),
            ElevatedButton(onPressed: (){
              updateDonor(docId);
            },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                child: Text('Update',style: TextStyle(fontSize: 20),))
          ],
        ),
      ),
    );
  }
}

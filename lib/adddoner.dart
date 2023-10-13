import 'package:blood_donar_app_first/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDoner extends StatefulWidget {
  const AddDoner({Key? key});

  @override
  State<AddDoner> createState() => _AddDonerState();
}

TextEditingController _namecontroller = TextEditingController();
TextEditingController _phonecontroller = TextEditingController();
TextEditingController _ageecontroller = TextEditingController();

class _AddDonerState extends State<AddDoner> {
  final droplist = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB-', 'AB+'];
  String? selactedbloodgruop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 186, 184),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Add Doner Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Pleace Add Details'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                  hintText: 'Name',
                  label: Text('Name'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phonecontroller,
              decoration: InputDecoration(
                  hintText: 'Phone',
                  label: Text('Phone'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageecontroller,
              decoration: InputDecoration(
                  label: Text('Age'),
                  hintText: 'Age',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField<String>(
              // value: selactedbloodgruop,
              items: droplist
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selactedbloodgruop = value;
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_namecontroller.text.isNotEmpty &&
                    _phonecontroller.text.isNotEmpty &&
                    _ageecontroller.text.isNotEmpty &&
                    selactedbloodgruop != null) {
                  FirebaseFirestore.instance.collection('doner').add({
                    'name': _namecontroller.text,
                    'phone': _phonecontroller.text,
                    'age': _ageecontroller.text,
                    'gruop': selactedbloodgruop.toString(),
                  }).then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill out the form')));
                }
              },
              child: Text('Submit'))
        ],
      ),
    );
  }
}

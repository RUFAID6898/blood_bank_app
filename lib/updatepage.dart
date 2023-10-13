import 'package:blood_donar_app_first/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

TextEditingController _namecontroller = TextEditingController();
TextEditingController _phonecontroller = TextEditingController();
TextEditingController _agecontroller = TextEditingController();

class _UpdatePageState extends State<UpdatePage> {
  final droplist = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB-', 'AB+'];

  String? selactedbloodgruop;
  final CollectionReference opencolloction =
      FirebaseFirestore.instance.collection('doner');

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    _namecontroller.text = args['name'];
    _agecontroller.text = args['age'];
    _phonecontroller.text = args['phone'];
    String selactedbloodgruop = args['blood gruop'].toString();
    final docid = args['id'];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 186, 184),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.red,
        title: Text('Edit Doner Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('Update Details'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _agecontroller,
              decoration: InputDecoration(
                  hintText: 'age',
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonFormField(
              // value: selactedbloodgruop.toString(),
              // validator: (value) => selactedbloodgruop = value.toString(),
              items: droplist
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) => selactedbloodgruop = value.toString(),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                opencolloction.doc(docid).update({
                  'name': _namecontroller.text,
                  'phone': _phonecontroller.text,
                  'age': _agecontroller.text,
                  'blood gruop': selactedbloodgruop
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: Text('update'))
        ],
      ),
    );
  }
}

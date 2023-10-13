import 'package:blood_donar_app_first/adddoner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  // Future<QuerySnapshot> getData() async {
  final donorCollection = FirebaseFirestore.instance.collection('doner');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOOD DONATION APP'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDoner(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        // future: getData(),
        stream: donorCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot snap = snapshot.data!.docs[index];
                return Card(
                  shadowColor: Colors.black,
                  elevation: 10,
                  color: Color.fromARGB(255, 243, 99, 99),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/update', arguments: {
                        'name': snap['name'],
                        'age': snap['age'],
                        'phone': snap['phone'],
                        'gruop': snap['gruop'],
                        'id': snap.id,
                      });
                    },
                    // leading: Text(snap['gruop']),
                    leading: CircleAvatar(
                      child: Text(snap['gruop']),
                    ),
                    title: Text(snap['name']),

                    // subtitle: Text(snap['phone']),
                    subtitle: Text('Tap to Edit'),
                    trailing: IconButton(
                      onPressed: () {
                        donorCollection.doc(snap.id).delete();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

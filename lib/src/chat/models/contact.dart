import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String id;
  final String email;
  final String image;
  final Timestamp lastseen;
  final String name;

  Contact({this.id, this.email, this.name, this.image, this.lastseen});

  factory Contact.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    return Contact(
      id: snapshot.id,
      lastseen: data["lastSeen"],
      email: data["email"],
      name: data["name"],
      image: data["image"],
    );
  }
}

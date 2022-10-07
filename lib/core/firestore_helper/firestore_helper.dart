import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory =>
      _firestore.collection('users').doc(_auth.currentUser!.uid).collection('meeting').snapshots();

  void addToMeetingHistory({required String roomName}) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('meeting').add({
        'meetingName': roomName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}

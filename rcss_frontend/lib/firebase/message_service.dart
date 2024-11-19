import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> updateUnreadMessagesCount(String userId, int unreadCount) async {
    await _db.collection('users').doc(userId).set(
      {'unreadMessages': unreadCount},
      SetOptions(merge: true),
    );
  }

  Future<int> getUnreadMessagesCount(String userId) async {
    var doc = await _db.collection('users').doc(userId).get();

    if (doc.exists) {
      if (doc.data()?['unreadMessages']) {
        return doc.data()!['unreadMessages'];
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Stream<int> getUnreadMessagesCountStream(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        if (doc.data()?['unreadMessages']) {
          return doc.data()!['unreadMessages'];
        } else {
          return 0;
        }
      } else {
        return 0;
      }
    });
  }
}

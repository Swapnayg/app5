import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/conversation.dart';
import '../models/message.dart';

class DBService {
  static DBService instance = DBService();

  FirebaseFirestore _db;

  DBService() {
    _db = FirebaseFirestore.instance;
  }

  final String _conversationsCollection = "Conversations";

  Future<void> updateChatTimeStamp(String conversationID) {
    var ref = _db.collection(_conversationsCollection).doc(conversationID);
    return ref.update({"timestamp": Timestamp.now()});
  }

  Future<void> sendMessage(String conversationID, Message message) {
    var ref =
        _db.collection(_conversationsCollection).doc(conversationID);
    var messageType = "";
    switch (message.type) {
      case MessageType.Text:
        messageType = "text";
        break;
      case MessageType.Image:
        messageType = "image";
        break;
      default:
    }
    return ref.update({
      "messages": FieldValue.arrayUnion(
        [
          {
            "message": message.content,
            "senderID": message.senderID,
            "timestamp": message.timestamp,
            "type": messageType,
          },
        ],
      ),
    }).then((value) => updateChatTimeStamp(conversationID));
  }

  Stream<Conversation> getConversation(String conversationID) {
    var ref =
        _db.collection(_conversationsCollection).doc(conversationID);
    return ref.snapshots().map(
      (doc) {
        return Conversation.fromFirestore(doc);
      },
    );
  }

  Stream<List<Conversation>> getConversations(String id) {
    var ref = _db
        .collection(_conversationsCollection)
        .orderBy("timestamp", descending: true) //Uncomment this line after creating indexes in firebase other will this query will not work
        .where("members", arrayContains: id);
    //Don't delete this, uncommenting this will give and erro in console with url to create indexes in firebase console.
    //click the url and create indexs
    ref.get().catchError((e) => print(e));
    return ref.get().asStream().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Conversation.fromFirestore(doc);
      }).toList();
    });
  }

  Future<String> getConversationId(String chatId, String userId, String userName, String userAvatar, String vendorId, String vendorName, String vendorAvatar, bool isVendor) async {
    var ref = _db.collection(_conversationsCollection);
    try {
      var conversation = await ref.doc(chatId).get();
      if (conversation.data() != null) {
        return chatId;//conversation.data["conversationID"];
      } else {
        await ref.doc(chatId).set(
          {
            "members": [userId, vendorId],
            'messages': [],
            "userId": userId,
            'userName': userName,
            'userAvatar': userAvatar,
            'vendorId': vendorId,
            'vendorName': vendorName,
            'vendorAvatar': vendorAvatar,
            'chatId': chatId
          }, SetOptions(merge: true)
        );
        return chatId; //TODO Replace with return value after adding docs
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  onError(e) {
    print(e);
  }
}

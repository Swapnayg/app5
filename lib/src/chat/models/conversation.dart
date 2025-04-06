import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';

class ConversationSnippet {
  final String id;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final MessageType type;
  final int unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {required this.conversationID,
      required this.id,
      required this.lastMessage,
      required this.unseenCount,
      required this.timestamp,
      required this.name,
      required this.image,
      required this.type});

  factory ConversationSnippet.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    var messageType = MessageType.Text;
    if (data["type"] != null) {
      switch (data["type"]) {
        case "text":
          break;
        case "image":
          messageType = MessageType.Image;
          break;
        default:
      }
    }
    return ConversationSnippet(
      id: snapshot.id,
      conversationID: data["conversationID"],
      lastMessage: data["lastMessage"] ?? "",
      unseenCount: data["unseenCount"],
      timestamp: data["timestamp"],
      name: data["name"],
      image: data["image"],
      type: messageType,
    );
  }
}

class Conversation {
  final String id;
  final List members;
  final List<Message> messages;
  final String userId;
  final String userName;
  final String userAvatar;
  final String vendorId;
  final String vendorName;
  final String vendorAvatar;
  final String chatId;
  final DateTime timeStamp;
  final DateTime vendorLastSeen;
  final DateTime userLastSeen;

  Conversation(
      {required this.id,
      required this.members,
      required this.userId,
      required this.messages,
      required this.userName,
      required this.userAvatar,
      required this.vendorId,
      required this.vendorName,
      required this.vendorAvatar,
      required this.chatId,
      required this.timeStamp,
      required this.vendorLastSeen,
      required this.userLastSeen});

  factory Conversation.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>?;
    List<dynamic> rawMessages = data?["messages"] ?? [];
    List<Message> messages = rawMessages.map(
      (m) {
        return Message(
            type: m["type"] == "text" ? MessageType.Text : MessageType.Image,
            content: m["message"],
            timestamp: m["timestamp"],
            senderID: m["senderID"]);
      },
    ).toList();
      return Conversation(
      id: snapshot.id,
      members: data!["members"],
      userId: data["userId"],
      messages: messages,
      userName: data["userName"],
      userAvatar: data["userAvatar"],
      vendorId: data["vendorId"],
      vendorName: data["vendorName"],
      vendorAvatar: data["vendorAvatar"],
      chatId: data["chatId"],
      timeStamp: data["timeStamp"],
      vendorLastSeen: data["vendorLastSeen"],
      userLastSeen: data["userLastSeen"],
    );
  }
}

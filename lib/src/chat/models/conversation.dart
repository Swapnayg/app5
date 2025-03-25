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
      {this.conversationID,
      this.id,
      this.lastMessage,
      this.unseenCount,
      this.timestamp,
      this.name,
      this.image,
      this.type});

  factory ConversationSnippet.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data();
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
      lastMessage: data["lastMessage"] != null ? data["lastMessage"] : "",
      unseenCount: data["unseenCount"],
      timestamp: data["timestamp"] != null ? data["timestamp"] : null,
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
      {this.id,
      this.members,
      this.userId,
      this.messages,
      this.userName,
      this.userAvatar,
      this.vendorId,
      this.vendorName,
      this.vendorAvatar,
      this.chatId,
      this.timeStamp,
      this.vendorLastSeen,
      this.userLastSeen});

  factory Conversation.fromFirestore(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    List messages = data["messages"];
    if (messages != null) {
      messages = messages.map(
        (m) {
          return Message(
              type: m["type"] == "text" ? MessageType.Text : MessageType.Image,
              content: m["message"],
              timestamp: m["timestamp"],
              senderID: m["senderID"]);
        },
      ).toList();
    } else {
      messages = [];
    }
    return Conversation(
      id: snapshot.documentID,
      members: data["members"],
      userId: data["userId"],
      messages: messages,
      userName: data["userName"],
      userAvatar: data["userAvatar"],
      vendorId: data["vendorId"],
      vendorName: data["vendorName"],
      vendorAvatar: data["vendorAvatar"],
      chatId: data["chatId"],
      timeStamp: data["timeStamp"] == null ? null : data["timeStamp"],
      vendorLastSeen: data["vendorLastSeen"] == null ? null : data["vendorLastSeen"],
      userLastSeen: data["userLastSeen"] == null ? null : data["userLastSeen"],
    );
  }
}

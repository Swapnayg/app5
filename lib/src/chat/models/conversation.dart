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

  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data() as Map<String, dynamic>;
    var _messageType = MessageType.Text;
    if (_data["type"] != null) {
      switch (_data["type"]) {
        case "text":
          break;
        case "image":
          _messageType = MessageType.Image;
          break;
        default:
      }
    }
    return ConversationSnippet(
      id: _snapshot.id,
      conversationID: _data["conversationID"],
      lastMessage: _data["lastMessage"] ?? "",
      unseenCount: _data["unseenCount"],
      timestamp: _data["timestamp"],
      name: _data["name"],
      image: _data["image"],
      type: _messageType,
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

  factory Conversation.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data() as Map<String, dynamic>?;
    List<dynamic> _rawMessages = _data?["messages"] ?? [];
    List<Message> _messages = _rawMessages.map(
      (_m) {
        return Message(
            type: _m["type"] == "text" ? MessageType.Text : MessageType.Image,
            content: _m["message"],
            timestamp: _m["timestamp"],
            senderID: _m["senderID"]);
      },
    ).toList();
      return Conversation(
      id: _snapshot.id,
      members: _data!["members"],
      userId: _data["userId"],
      messages: _messages,
      userName: _data["userName"],
      userAvatar: _data["userAvatar"],
      vendorId: _data["vendorId"],
      vendorName: _data["vendorName"],
      vendorAvatar: _data["vendorAvatar"],
      chatId: _data["chatId"],
      timeStamp: _data["timeStamp"],
      vendorLastSeen: _data["vendorLastSeen"],
      userLastSeen: _data["userLastSeen"],
    );
  }
}

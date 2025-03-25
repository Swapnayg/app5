import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/app_state_model.dart';
import '../models/conversation.dart';
import '../models/message.dart';
import '../services/db_service.dart';
import 'chat_page.dart';

class ChatRoomList extends StatefulWidget {
  final String id;
  const ChatRoomList({Key key, this.id}) : super(key: key);
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  double _height;
  double _width;
  final appStateModel = AppStateModel();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Text(appStateModel.blocks.localeText.chat),
      ),
      body: SizedBox(
        height: _height,
        width: _width,
        child: _conversationsListViewWidget(),
      ),
    );
  }

  Widget _conversationsListViewWidget() {
    return StreamBuilder<List<Conversation>>(
      stream: DBService.instance.getConversations(widget.id),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if (data != null) {
          return data.length != 0
              ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ChatPage(chatId: data[index].chatId, vendorId: data[index].vendorId, vendorName: data[index].vendorName, vendorAvatar: data[index].vendorAvatar
                        );
                      }));
                    },
                    title: appStateModel.user.id.toString() == data[index].userId ? Text(data[index].vendorName) : Text(data[index].userName),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                              data[index].messages.last.type == MessageType.Text
                                  ? data[index].messages.last.content
                                  : "Attachment: Image", maxLines: 2,),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            timeago.format(data[index].messages.last.timestamp.toDate()),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: appStateModel.user.id.toString() == data[index].userId ? NetworkImage(data[index].vendorAvatar) : NetworkImage(data[index].userAvatar),
                        ),
                      ),
                    ),
                  ),
                  Divider()
                ],
              );
            },
          )
              : Align(
            child: Text(
              appStateModel.blocks.localeText.noConversationsYet,
              style: TextStyle(fontSize: 15.0),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

import 'package:dashboard/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final void Function() isLoggedInCallback;
  const ChatScreen({Key? key, required this.isLoggedInCallback})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String adminId = 'ZDAcfbR3ycXfgx1ydbqTthosZ0Z2';
  bool isAdmin = false;

  final service = FirestoreService();
  final _messageController = TextEditingController();

  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            debugPrint("Logout User");
            FirebaseAuth.instance.signOut();
            widget.isLoggedInCallback();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isAdmin = !isAdmin;
              });
            },
            icon: Icon(
              Icons.verified_user,
              color: isAdmin ? Colors.green : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: MessageStreamer()),
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(width: 1.0),
                ),
                hintText: 'Enter message',
                suffixIcon: IconButton(
                  onPressed: () async {
                    isAdmin
                        ? await service.addChatMessage(adminId, uid, 'ChatID',
                            _messageController.text.trim(), '')
                        : await service.addChatMessage(uid, adminId, 'ChatID',
                            _messageController.text.trim(), '');
                    _messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStreamer extends StatefulWidget {
  const MessageStreamer({Key? key}) : super(key: key);

  @override
  State<MessageStreamer> createState() => _MessageStreamerState();
}

class _MessageStreamerState extends State<MessageStreamer> {
  final String adminId = 'ZDAcfbR3ycXfgx1ydbqTthosZ0Z2';

  final service = FirestoreService();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: service.getMessages(uid, 'ChatID', adminId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return ChatBubble(
              isMe: snapshot.data!.docs.reversed.toList()[index]['senderUid'] ==
                  uid,
              message: snapshot.data!.docs.reversed.toList()[index]['message']
                  as String,
            );
          },
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String message;
  const ChatBubble({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.teal,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )
                : const BorderRadius.all(Radius.circular(15)),
          ),
          child: Text(message),
        )
      ],
    );
  }
}

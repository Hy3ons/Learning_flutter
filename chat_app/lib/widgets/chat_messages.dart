import 'package:chat_app/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticatedUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createAt', descending: false)
              .snapshots(),
      builder: (ctx, snapshot) {
        //로딩 중 일때...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Message found.'));
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong..'));
        }

        final loadedMessage = snapshot.data!.docs;

        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 13, right: 13, bottom: 40),
            itemCount: loadedMessage.length,
            reverse: true,
            itemBuilder: (context, index) {
              final chatMessage = loadedMessage[index].data();
              final nextChatMessage =
                  index + 1 < loadedMessage.length
                      ? loadedMessage[index + 1]
                      : null;
              //
              final currentMessageUserId = chatMessage['userId'];
              final nextMessageUserId =
                  nextChatMessage != null ? nextChatMessage['userId'] : null;

              final nextUserIsSame = nextMessageUserId == currentMessageUserId;
              final isMe = currentMessageUserId == authenticatedUser.uid;

              if (nextUserIsSame) {
                return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: isMe,
                );
              } else {
                //
                return MessageBubble.first(
                  userImage: chatMessage['userImage'],
                  username: chatMessage['username'],
                  message: chatMessage['text'],
                  isMe: isMe,
                );
              }
            },
          ),
        );
      },
    );
  }
}

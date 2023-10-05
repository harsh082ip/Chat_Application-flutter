import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String uid1;
  String uid2;
  String text;
  bool isUserBlocked;

  ChatModel(
      {required this.uid1,
      required this.uid2,
      required this.text,
      required this.isUserBlocked});

  Future<void> sendMessage(bool istextAnImage) async {
    final CollectionReference chatCollection =
        FirebaseFirestore.instance.collection('chats');

    final chatSnapshot =
        await chatCollection.where('participants', arrayContains: uid1).get();

    final filteredChats = chatSnapshot.docs
        .where((doc) =>
            (doc['participants'] as List).contains(uid1) &&
            (doc['participants'] as List).contains(uid2))
        .toList();

    if (filteredChats.isNotEmpty) {
      final chatDoc = filteredChats.first;
      await chatDoc.reference.update({
        'messages': FieldValue.arrayUnion([
          {
            'sender_uid': uid1,
            'recever_uid': uid2,
            'text': text,
            'istextAnImage': istextAnImage,
          }
        ])
      });
    } else {
      final newChatDOc = await chatCollection.add({
        'participants': [uid1, uid2],
        'messages': [
          {
            'sender_uid': uid1,
            'recever_uid': uid2,
            'text': text,
            'istextAnImage': istextAnImage,
          }
        ],
        "isChatBlocked": false,
        "whoHasBlocked": "none",
      });
    }
  }
}

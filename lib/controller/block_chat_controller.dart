import 'dart:developer';

import 'package:chat_application/controller/fetch_info_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class BlockChat_Controller {
  static void updateBlockStatus(String docId, bool blockStatus,
      {String whoHasBlocked = "none"}) async {
    log("---here----");
    log(docId);
    log(blockStatus.toString());
    log(whoHasBlocked);
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(docId)
        .update({"isChatBlocked": blockStatus, "whoHasBlocked": whoHasBlocked});
    log("---here----");
  }

  // fetch current blockStatus
  static Future<bool> fetchBlockStatus(String uid2) async {
    final QuerySnapshot snapshot =
        await Fetch_Info.fetchChats(FirebaseAuth.instance.currentUser!.uid)
            .first;
    final messages = snapshot.docs
        .where((doc) =>
            (doc['participants'] as List)
                .contains(FirebaseAuth.instance.currentUser!.uid) &&
            (doc['participants'] as List).contains(uid2))
        .toList();

    if (messages.isNotEmpty) {
      return messages[0]['isChatBlocked'] ?? false;
    } else {
      return false; // Return a default value if no matching document is found.
    }
  }

  // fetch current user whoHasblocked
  static Future<String> fetchBlockUser(String uid2) async {
    final QuerySnapshot snapshot =
        await Fetch_Info.fetchChats(FirebaseAuth.instance.currentUser!.uid)
            .first;
    final messages = snapshot.docs
        .where((doc) =>
            (doc['participants'] as List)
                .contains(FirebaseAuth.instance.currentUser!.uid) &&
            (doc['participants'] as List).contains(uid2))
        .toList();

    if (messages.isNotEmpty) {
      return messages[0]['whoHasBlocked'] ?? "";
    } else {
      return "none"; // Return a default value if no matching document is found.
    }
  }
}

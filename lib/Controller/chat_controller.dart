import 'package:bunyaad/Model/chat_group.dart';
import 'package:bunyaad/Model/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  static Future<void> sendConversationMessage(
      String chatRoomID, ChatMessage message) async {
    DocumentReference ref = await FirebaseFirestore.instance
        .collection("ChatGroup")
        .doc(chatRoomID)
        .collection("Chats")
        .add(message.toJSON());
    ref.update({"chatRoomId":ref.id});
  }
  static getConversationMessage(
      String chatRoomID) {
    return FirebaseFirestore.instance
        .collection("ChatGroup").doc(chatRoomID).collection("Chats").snapshots();
  }

  static Future<void> createChatGroup(
      String sellerId, ChatGroup chatGroup
      ) async{
    DocumentReference ref =  await FirebaseFirestore.instance
        .collection("ChatGroup")
        .add(chatGroup.toJSON());
    ref.update({"chatRoomId":ref.id});
  }

  static Future<void> getChatGroupSeller(
      String sellerId
      ) async{
    await FirebaseFirestore.instance
        .collection("ChatGroup").where("seller", isEqualTo: sellerId).get();
        // .add(chatGroup.toJSON());
  }
  static Future<void> getChatGroupBuyer(
      String buyerId
      ) async{
    await FirebaseFirestore.instance
        .collection("ChatGroup").where("buyer", isEqualTo: buyerId).get();
  }
}

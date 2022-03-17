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

  static Future<String> createChatGroup(ChatGroup chatGroup) async{
    DocumentReference ref =  await FirebaseFirestore.instance
        .collection("ChatGroup")
        .add(chatGroup.toJSON());
    ref.update({"chatRoomId":ref.id});
    return ref.id;
  }

  static Future<String> getChatGroupSeller(
      String sellerId
      ) async{
    QuerySnapshot ref = await FirebaseFirestore.instance
        .collection("ChatGroup")
        .where("seller", isEqualTo:sellerId)
        .get();
    List<QueryDocumentSnapshot> data = ref.docs;
    for (int a = 0; a < data.length; a++) {
      return fromJSON(data[a].data());
      //return doc!["chatRoomId"];
    }
    return "-1";
  }

  static String fromJSON(var doc) {
    var Seller = doc["chatRoomId"];
    return Seller;
  }
  static Future<void> getChatGroupBuyer(
      String buyerId
      ) async{
    await FirebaseFirestore.instance
        .collection("ChatGroup").where("buyer", isEqualTo: buyerId).get();
  }
}

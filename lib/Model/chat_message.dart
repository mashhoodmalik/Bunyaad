class ChatMessage {
  String chatRoomId = "";
  String message = "";
  String sender = "";

  void populateBuyer({var chatRoomId, var message, var sender}) {
    this.chatRoomId = chatRoomId;
    this.message = message;
    this.sender = sender;
  }

  void fromJSON(var doc) {
    sender = doc["sender"];
    message = doc["message"];
    chatRoomId = doc["chatRoomId"];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> uploadDoc = Map();
    uploadDoc = {"message": message, "chatRoomId": chatRoomId, "sender": sender,"timeStamp":DateTime.now().microsecondsSinceEpoch};
    return uploadDoc;
  }
}

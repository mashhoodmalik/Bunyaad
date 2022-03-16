class ChatGroup {
  String chatRoomId = "";
  String seller = "";
  String buyer = "";

  void populateBuyer({var chatRoomId, var seller, var buyer}) {
    this.chatRoomId = chatRoomId;
    this.seller = seller;
    this.buyer = buyer;
  }

  void fromJSON(var doc) {
    buyer = doc["buyer"];
    seller = doc["seller"];
    chatRoomId = doc["chatRoomId"];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> uploadDoc = Map();

    uploadDoc = {"seller": seller, "chatRoomId": chatRoomId, "buyer": buyer};
    return uploadDoc;
  }
}

class ChatGroup {
  String chatRoomId = "";
  String seller = "";
  String buyer = "";
  String sellerName = "";
  String buyerName = "";

  void populateBuyer({var chatRoomId, var seller, var buyer,var sellerName,var buyerName}) {
    this.chatRoomId = chatRoomId;
    this.seller = seller;
    this.buyer = buyer;
    this.sellerName = sellerName;
    this.buyerName = buyerName;
  }

  void fromJSON(var doc) {
    buyer = doc["buyer"];
    seller = doc["seller"];
    chatRoomId = doc["chatRoomId"];
    sellerName = doc["sellerName"];
    buyerName = doc["buyerName"];
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> uploadDoc = Map();

    uploadDoc = {"seller": seller, "chatRoomId": chatRoomId, "buyer": buyer,"sellerName":sellerName,"buyerName":buyerName};
    return uploadDoc;
  }
}

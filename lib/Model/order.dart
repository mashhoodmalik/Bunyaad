class Order {
  String orderId = "";
  String productId = "";
  String confirm = "pending";
  String sellerId = "";
  String buyerId = "";
  String productName = "";
  String quantity = "";
  String buyerName = "";
  String isComplete = "";

  void placeOrder({required String buyerId,required String buyerName,required String sellerId,
    required String productName,required String productId,required String quantity}){
    this.buyerId = buyerId;
    this.productId = productId;
    this.buyerName = buyerName;
    this.sellerId = sellerId;
    this.productName = productName;
    this.quantity = quantity;
  }

  void confirmOrder({required String confirm}){
    this.confirm = confirm;
  }

  void shipOrder({required String complete}){
    isComplete =complete;
  }

  void fromJSON( var doc){
    orderId = doc["id"];
    productName = doc["productName"];
    quantity = doc["quantity"];
    productId = doc["productId"];
    sellerId = doc["sellerId"];
    buyerId = doc["buyerId"];
    buyerName = doc["buyerName"];
    confirm = doc["confirm"];
    isComplete = doc["isComplete"];
  }

  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "productName":productName,
      "quantity":quantity,
      "sellerId":sellerId,
      "buyerId":buyerId,
      "buyerName":buyerName,
      "confirm":confirm,
      "productId":productId,
      "isComplete":isComplete
    };
    return uploadDoc;
  }

}
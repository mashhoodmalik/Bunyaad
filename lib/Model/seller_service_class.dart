class SellerServiceClass{
  String description = "";
  String title ="";
  List<String> imageLink = [""];
  String docId ="";
  String sellerID ="";


  void populateService({var description,var sellerID,var title,var imageLink}){
    this.description = description.text.toString();
    this.title = title.text.toString();
    this.sellerID = sellerID;
    this.imageLink  = imageLink;
  }

  void fromJSON( var doc){
    docId = doc["ID"];
    description = doc["description"];
    sellerID = doc["buyerId"];
    title = doc["title"];
    imageLink = doc["imageLink"];
  }

  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "description":description,
      "sellerID":sellerID,
      "title":title,
      "imageLink":imageLink,
    };
    return uploadDoc;
  }
}
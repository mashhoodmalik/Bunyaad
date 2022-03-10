class BuyerRequestClass{
  String description = "";
  String timeDuration ="";
  String docId ="";
  String buyerID ="";
  String budget = "";
  String responses = "";

  void populateBuyer({var description,var budget,var buyerID,var timeDuration,var responses=""}){
    this.description = description.text.toString();
    this.timeDuration = timeDuration.text.toString();
    this.buyerID = buyerID;
    this.budget = budget.text.toString();
    this.responses = responses;
    //print(nameS);

  }

  void fromJSON( var doc){
    docId = doc["ID"];
    description = doc["description"];
    buyerID = doc["buyerId"];
    timeDuration = doc["timeDuration"];
    budget = doc["budget"];
    // responses = doc["responses"];
  }

  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "description":description,
      "buyerId":buyerID,
      "timeDuration":timeDuration,
      "budget":budget,
      "responses":responses,
    };
    return uploadDoc;
  }

}
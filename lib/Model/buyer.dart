class Buyer{

  String userName = "";
  String name ="";
  String docId ="";
  String email ="";
  int isSeller = 0;
  String imageLink = "https://firebasestorage.googleapis.com/v0/b/bunyaaddb.appspot.com/o/defaultImages%2Fperson-icon.png?alt=media&token=8e271d89-2280-4973-9e0c-ba01ee39154f";
  List<dynamic> nameS = [];

  void populateBuyer({var userName,var name,var email}){
    this.userName = userName.text.toString();
    this.name = name.text.toString();
    this.email = email.text.toString();
    nameS = [this.name[0].toLowerCase()];
    for(int i = 1;i<this.name.length;i++){
      nameS.add(nameS.elementAt(i-1)+this.name[i].toLowerCase());
    }

    //print(nameS);

  }

  void fromJSON( var doc){
    docId = doc["id"];
    name = doc["name"];
    email = doc["email"];
    userName = doc["userName"];
    nameS = doc["nameS"];
    imageLink = doc["imageLink"];
  }

  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "name":name,
      "userName":userName,
      "email":email,
      "isSeller":isSeller,
      "nameS":nameS,
      "imageLink":imageLink,
    };
    return uploadDoc;
  }


}
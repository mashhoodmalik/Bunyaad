class Seller{
  String userName = "";
  String businessName = "";
  String name ="";
  String docId ="";
  String email ="";
  String phoneNumber = "";
  String address = "";
  String city = "";
  String taxId = "";
  String imageLink = "https://firebasestorage.googleapis.com/v0/b/bunyaaddb.appspot.com/o/defaultImages%2Fperson-icon.png?alt=media&token=8e271d89-2280-4973-9e0c-ba01ee39154f";
  int isSeller = 1;


  List<dynamic> nameS = [];
  void populateSeller({var userName,var name,var email, var phoneNumber, var address, var city, var taxId, var businessName}){
    this.userName = userName.text.toString();
    this.businessName = businessName.text.toString();
    this.name = name.text.toString();
    this.email = email.text.toString();
    this.phoneNumber = phoneNumber.text.toString();
    this.address = address.text.toString();
    this.city = city.text.toString();
    this.taxId = taxId.text.toString();
    nameS = [this.name[0].toLowerCase()];
    for(int i = 1;i<this.name.length;i++){
      nameS.add(nameS.elementAt(i-1)+this.name[i].toLowerCase());
    }
    print(nameS);
}
  void fromJSON( var doc){
    docId = doc["id"];
    name = doc["name"];
    businessName = doc["businessName"];
    email = doc["email"];
    userName = doc["userName"];
    phoneNumber = doc["phoneNumber"];
    address = doc["address"];
    city = doc["city"];
    taxId = doc["taxId"];
    imageLink = doc["imageLink"];
    nameS = doc["nameS"];
  }
  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "name":name,
      "userName":userName,
      "businessName":businessName,
      "email":email,
      "isSeller":isSeller,
      "phoneNumber":phoneNumber,
      "address":address,
      "city":city,
      "taxId":taxId,
      "imageLink":imageLink,
      "nameS":nameS
    };
    return uploadDoc;
  }
}
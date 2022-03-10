class Seller{
  String userName = "";
  String name ="";
  String docId ="";
  String email ="";
  String phoneNumber = "";
  String address = "";
  String city = "";
  String taxId = "";
  int isSeller = 1;


  List<dynamic> nameSeller = [];
  void populateSeller({var userName,var name,var email, var phoneNumber, var address, var city, var taxId}){
    this.userName = userName.text.toString();
    this.name = name.text.toString();
    this.email = email.text.toString();
    this.phoneNumber = phoneNumber.text.toString();
    this.address = address.text.toString();
    this.city = city.text.toString();
    this.taxId = taxId.text.toString();
    nameSeller = [this.name[0].toLowerCase()];
    for(int i = 1;i<this.name.length;i++){
      nameSeller.add(nameSeller.elementAt(i-1)+this.name[i].toLowerCase());
    }
    print(nameSeller);
}
  void fromJSON( var doc){
    docId = doc["id"];
    name = doc["name"];
    email = doc["email"];
    userName = doc["userName"];
    phoneNumber = doc["phoneNumber"];
    address = doc["address"];
    city = doc["city"];
    taxId = doc["taxId"];
    nameSeller = doc["nameSeller"];
  }
  Map<String,dynamic> toJSON(){
    Map<String,dynamic> uploadDoc = Map();

    uploadDoc = {
      "name":name,
      "userName":userName,
      "email":email,
      "isSeller":isSeller,
      "phoneNumber":phoneNumber,
      "address":address,
      "city":city,
      "taxId":taxId,
      "nameSeller":nameSeller
    };
    return uploadDoc;
  }
}
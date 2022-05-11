class Service{//Basic service model
  String sid = "";
  String name = "";
  String desc="";
  List<dynamic> nameL = [];
  String category="";
  String area="";
  String image="";
  String unit="";
  String uid="";
  String price = "";

  String sellerName = "";

  void populateService({var name,var desc,var price,var sellerId,var sellerName}){
    this.name = name;
    this.desc = desc;
    this.price = price;
    this.sellerName = sellerName;
    image = "https://firebasestorage.googleapis.com/v0/b/bunyaaddb.appspot.com/o/defaultImages%2Fperson-icon.png?alt=media&token=8e271d89-2280-4973-9e0c-ba01ee39154f";
    uid = sellerId;
    area = "rawalpindi";
    category = "general";
    unit = "per piece";
    this.nameL = [this.name[0].toLowerCase()];
    for(int i = 1;i<this.name.length;i++){
      this.nameL.add(this.nameL.elementAt(i-1)+this.name[i].toLowerCase());
    }
  }

  static Service fromJson(var data){
    Service objectService = new Service();
    objectService.sid = data["sid"];
    objectService.name = data["Name"];
    objectService.area=  data["Area"];
    objectService.category = data["Category"];
    objectService.desc = data["Description"];
    objectService.unit = data["Rate"];
    objectService.price = data["Price"];
    objectService.uid = data["uid"];
    objectService.image = data["userimage"];
    objectService.sellerName = data["sellerName"];

    return objectService;
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> objectMap = {
      "Name" : this.name,
      "Area": this.area,
      "Category": this.category,
      "Description": this.desc,
      "Rate":this.unit,
      "Price":this.price,
      "uid":this.uid,
      "time":DateTime.now().microsecondsSinceEpoch.toString(),
      "image":this.image,
      "sellerName":this.sellerName,
      "userimage":this.image,
      "NameL":this.nameL,
    };

    return objectMap;
  }
}
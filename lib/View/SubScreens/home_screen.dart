import 'package:bunyaad/View/Model/Style.dart';
import 'package:flutter/material.dart';
import '../Widgets/Search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FocusNode focusNode = FocusNode();
  bool isLiked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.backgroundColor(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,)
        ),
        title: Text("Bunyaad", style: Style.heading(),),
        actions: [
          ClipOval(
            child: IconButton(
                onPressed: (){},
                icon: Icon(Icons.switch_account_rounded,color:Colors.black87,size: 32,)
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SearchBar(
                  searchFunction: (){

                  },
                  onChanged: (value){

                  }, focusNode: focusNode),
            ),
            SizedBox(height: 24,),
            Expanded(
              child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (BuildContext context,index){
                return buildDescriptionCard(context);
              }, separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 12,);
              },),
            )
          ],
        ),
      ),
    );
  }



  Widget buildDescriptionCard(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal:16),
      decoration: BoxDecoration(
        border: Border.all(),
        // borderRadius: BorderRadius.circular(25),
        // color:  Style.defaultHeadingColor,
      ),
      height: 200,
      width: MediaQuery.of(context).size.width*0.9,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
                  color: Colors.black87,
                  height: 100,
                ),
              ),
              Expanded(
                  flex:1,child: GestureDetector(
                  onTap: (){
                    isLiked = !isLiked;
                    setState(() {

                    });
                  },
                  child: isLiked==true?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border))),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    width: 32,
                    height: 32,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Text("Item Name",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height: 8,),
                      Text("Short Description",style: TextStyle(color: Colors.black87,fontStyle: FontStyle.italic,fontSize: 16),)
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text("Price"),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}

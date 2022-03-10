
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key, required this.onChanged, this.searchFunction,required this.focusNode})
      : super(key: key);
  final void Function(String)? onChanged;
  final void Function()? searchFunction;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      child: TextFormField(
        autofocus: false,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.grey),
            ),
            hintText: "Search here",
            hintStyle: TextStyle(color:Colors.grey),
            suffixIcon:       // Figma Flutter Generator Ellipse2Widget - ELLIPSE
            Padding(
              padding: EdgeInsets.all(6),
              child:
              IconButton(
                onPressed: searchFunction,
                icon: Icon(Icons.search,color: Colors.grey,),
              ),
              /*Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color : Color.fromRGBO(25, 42, 48, 1),
                  borderRadius : BorderRadius.all(Radius.elliptical(42, 42)),
                ),
              child: IconButton(
                onPressed: searchFunction,
                icon: Icon(Icons.search,color: Colors.white,),
              ),
            ),*/
            )
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}
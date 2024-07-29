import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  String TextContent;
  void Function() onTap;
   CustomButton(this.TextContent,this.onTap);

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
              TextContent,
              style: TextStyle(fontSize: 22, color: Color(0xff26435e)),
            )),
      ),
    );
  }
}

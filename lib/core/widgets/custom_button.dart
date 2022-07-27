import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,required this.text, this.onTap}) : super(key: key);

  final String text;
 final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal:25.0 ,vertical: 25.0),
        height: 50 ,
        width: double.infinity,

        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(15.0)
        ),

        child:  Center(child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)) , ),
      ),
    );
  }
}

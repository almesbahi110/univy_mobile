import 'package:flutter/material.dart';
import 'package:univy_mobile/ui/pages/task_manager/theme.dart';
class MyButtom extends StatelessWidget {
  final String label;
  final Function()? onTap;
   MyButtom({Key? key,required this.label,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        child: Center(child: Text(label,style: TextStyle(color: Colors.white),)),
      ),
    );
  }
}

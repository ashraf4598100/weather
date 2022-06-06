import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../core/routes/routes.gr.dart';

import '../widgets/date_picker_widget.dart';




  String ? date;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        
      decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/homeBackground.jpeg",),fit: BoxFit.fill)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Weather App",style: TextStyle(color: Colors.white,fontSize: 30.sp,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
          Center(
            child:DatePickerWidget(getDate: (date){
              date = date;
              context.router.push(Weather(date: date));
            }),),
        ],
      ),
      ),
    );
  }

}
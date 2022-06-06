import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class DatePickerWidget extends StatefulWidget {
  final Function getDate;
  const DatePickerWidget({Key? key, required this.getDate}) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {


    return GestureDetector(onTap: (){
showDatePicker()
;
    },
      child: Container(
        height: 50.h,
        width: 150.w,
        decoration:  BoxDecoration(color:  Colors.grey[300],borderRadius: const BorderRadius.all(Radius.circular(20),
        
        )),
        child: Center(child: Text("Select Date",style: TextStyle(color: const Color.fromARGB(255, 59, 59, 59),fontSize: 15.sp,fontWeight: FontWeight.w600),)),
    
      ),
    );
  }
  showDatePicker (){
     return DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime:DateTime.now(),
                      maxTime: DateTime.now().add(const Duration(days: 2)),
                      theme:  DatePickerTheme(
                          headerColor: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
                          itemStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16.sp)),
                      onChanged: (date) {
                 
                  }, onConfirm: (date) {
                    widget.getDate(date);
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
          
 
  
}
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:univy_mobile/controllers/task_cotroller.dart';
import 'package:univy_mobile/models/task.dart';
import 'package:univy_mobile/ui/pages/task_manager/theme.dart';
import 'package:univy_mobile/ui/pages/task_manager/widgets/button.dart';
import 'package:univy_mobile/ui/pages/task_manager/widgets/input_file.dart';
import 'dart:ui' as ui;
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController=Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nodeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int _selectedRemaind = 5;
  List<int> remindList = [5, 10, 15, 20];

 // String _selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(context),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'إضافة مهمة',
                  style: headingStyle,
                ),
                MyInputField(title: "العنوان", hint: "  يرجى إدخال العنوان",controller: _titleController,),
                MyInputField(title: "ملاحظات", hint: "  يرجى إدخال الملاحظات",controller: _nodeController,),
                MyInputField(
                  title: "التاريخ",
                  hint: "  ${ DateFormat.yMd().format(_selectedDate)}",
                  widget: IconButton(
                      onPressed: () {
                        _getDateFromUser();
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      )),
                ),
                Row(
                  children: [
                    Expanded(
                        child: MyInputField(
                      title: "الساعة",
                      hint: "  $_startTime",
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
                // MyInputField(
                //   title: "التكرار",
                //   hint: "    $_selectedRepeat",
                //   widget: DropdownButton(
                //     icon: Icon(
                //       Icons.keyboard_arrow_down,
                //       color: Colors.grey,
                //     ),
                //     underline: Container(
                //       height: 0,
                //     ),
                //     iconSize: 32,
                //     elevation: 4,
                //     style: subTitleStyle,
                //     onChanged: (String? newValue) {
                //       setState(() {
                //         _selectedRepeat = newValue!;
                //       });
                //     },
                //     items:
                //         repeatList.map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem(
                //           value: value,
                //           child: Text(
                //             value,
                //             style: TextStyle(color: Colors.grey),
                //           ));
                //     }).toList(),
                //   ),
                // ),

                SizedBox(height:50 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                    MyButtom(label: "إنشاء المهمة", onTap: ()=>_validteDate())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validteDate() {
    if (_titleController.text.isNotEmpty && _nodeController.text.isNotEmpty) {
      //add to data base
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _nodeController.text.isEmpty) {
      Get.snackbar("عذراً", "جميع الحقول اجبارية",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_rounded),
        colorText: Colors.red
      );
    }
  }


  _addTaskToDb()async
  {
 //int value= await  _taskController.addTask(
  await  _taskController.addTask(
      task: Task(
        isCompleted: 0,
        color: _selectedColor,
      //  repeat: _selectedRepeat,
        repeat: "Daily",
        remind: _selectedRemaind,
        endTime: _endTime,
        startTime: _startTime,
        date: DateFormat.yMd().format(_selectedDate),
        title: _titleController.text,
        note: _nodeController.text,


      )
    );
  }



  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "اللون",
          style: titleStyle,
        ),
        SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: _selectedColor == index
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),

    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2100));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("its null or something is woring");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time Cancel");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])));
  }
}

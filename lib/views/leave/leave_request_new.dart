import 'package:cws_app/network/api_client.dart';
import 'package:cws_app/util/app_storage.dart';
import 'package:cws_app/widgets/constant.dart';
import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

import '../../util/app_utils.dart';

class CustomCupertinoTabBar extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget> widgets;
  final int Function() valueGetter;
  final Function(int) onTap;
  final bool useSeparators;
  final double innerHorizontalPadding;
  final double innerVerticalPadding;
  final BorderRadius borderRadius;
  final Curve curve;
  final Duration duration;
  final bool allowExpand;
  final bool allowScrollable;
  final bool fittedWhenScrollable;
  final bool animateWhenScrollable;
  final bool animateUntilScrolled;
  final double outerHorizontalPadding;
  final double outerVerticalPadding;

  CustomCupertinoTabBar({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.widgets,
    required this.valueGetter,
    required this.onTap,
    this.useSeparators = false,
    this.innerHorizontalPadding = 10.0,
    this.innerVerticalPadding = 10.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.curve = Curves.linearToEaseOut,
    this.duration = const Duration(milliseconds: 350),
    this.allowExpand = false,
    this.allowScrollable = false,
    this.fittedWhenScrollable = false,
    this.animateWhenScrollable = false,
    this.animateUntilScrolled = false,
    this.outerHorizontalPadding = 10.0,
    this.outerVerticalPadding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: outerHorizontalPadding,
        vertical: 12,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widgets.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(index),
                child: AnimatedContainer(
                  duration: duration,
                  curve: curve,
                  decoration: BoxDecoration(
                    color: valueGetter() == index
                        ? foregroundColor
                        : backgroundColor,
                    borderRadius: borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultTextStyle(
                        style: TextStyle(
                          color: valueGetter() == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                        child: Center(child: widgets[index])),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class CustomTabBarDemo extends StatefulWidget {
  const CustomTabBarDemo({super.key});

  @override
  _CustomTabBarDemoState createState() => _CustomTabBarDemoState();
}

class _CustomTabBarDemoState extends State<CustomTabBarDemo> {
  int cupertinoTabBarValue = 0;
  RxBool isLoading = false.obs;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;
  String selectedDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  int leaveDays = 1;
  HalfDay _selectedHalf = HalfDay.firstHalf;
  String leaveType = "Select Leave Type";
  TextEditingController _reasonController = TextEditingController();
  List<String> optionsList = [
    "Select Leave Type",
    "Casual Leave",
    "Sick Leave",
    "Earned Leave",
    "Maternity Leave",
    "Paternity Leave",
    "Compensatory Leave",
    "Special Leave",
    "Unpaid Leave",
    "Others",
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked.toString().substring(0, 10);
        endDate = picked.toString().substring(0, 10);
        leaveDays = 1;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 1)),
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked.start.toString().substring(0, 10);
        endDate = picked.end.toString().substring(0, 10);
        leaveDays = picked.end.difference(picked.start).inDays + 1;
      });
    }
  }

  Future<void> uploadData() async {
    isLoading.value = true;
    var userId = AppStorage.getUserId();
    var data = {
      "emp_id": userId,
      "leave_days": cupertinoTabBarValue == 0 ? "0.5" : leaveDays.toString(),
      "start_date": selectedDate,
      "end_date": endDate,
      "leave_reason": _reasonController.text,
      "halfday_type": cupertinoTabBarValue == 0
          ? _selectedHalf == HalfDay.firstHalf
              ? "First half"
              : "Second half"
          : '',
      "type_reason": leaveType,
      "day_type": cupertinoTabBarValue == 0
          ? "1"
          : cupertinoTabBarValue == 1
              ? "2"
              : "3",
    };

    print(data);

    var response = await ApiClient.post("Common/leave_request", data);

    print(response.body);
    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 200) {
      print("Success");

      AppUtils.snackBar('Leave applied successfully');
      Get.back();
    } else {
      print("Failed");
      AppUtils.snackBar('Failed to apply leave');
    }
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(color: appthemColor),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              'APPLY FOR LEAVE',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            leading: AppUtils.backButton(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomCupertinoTabBar(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: appthemColor,
                borderRadius: BorderRadius.circular(50),
                widgets: [
                  Text('HALF-DAY'),
                  Text('FULL-DAY'),
                  Text('Period'),
                ],
                valueGetter: cupertinoTabBarValueGetter,
                onTap: (int index) {
                  setState(() {
                    cupertinoTabBarValue = index;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (cupertinoTabBarValue == 2) {
                              _selectDateRange(context);
                            } else {
                              _selectDate(context);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: cupertinoTabBarValue == 2
                                ? MediaQuery.of(context).size.width * 0.7
                                : MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      cupertinoTabBarValue == 2
                                          ? "$selectedDate to $endDate"
                                          : selectedDate,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_drop_down),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    cupertinoTabBarValue == 0
                        ? SizedBox(height: 10)
                        : SizedBox.shrink(),
                    cupertinoTabBarValue == 0
                        ? Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 10),
                    cupertinoTabBarValue == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Radio<HalfDay>(
                                      value: HalfDay.firstHalf,
                                      groupValue: _selectedHalf,
                                      onChanged: (HalfDay? value) {
                                        setState(() {
                                          _selectedHalf = value!;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "First half",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio<HalfDay>(
                                      value: HalfDay.secondHalf,
                                      groupValue: _selectedHalf,
                                      onChanged: (HalfDay? value) {
                                        setState(() {
                                          _selectedHalf = value!;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Second half",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.grey.shade200,
                      ),
                      child: DropdownButtonFormField<String>(
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: leaveType,
                        onChanged: (String? newValue) {
                          setState(() {
                            leaveType = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select leave type";
                          }
                          return null;
                        },
                        items: optionsList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Reason',
                          style: TextStyle(color: Colors.grey.shade700)),
                    ),
                    TextFormField(
                      maxLines: 3,
                      controller: _reasonController,
                      decoration: InputDecoration(
                        // labelText: 'Reason',
                        hintText: 'Enter Reason',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(() => ElevatedButton(
                          onPressed: isLoading.value
                              ? null
                              : () async {
                                  if (leaveType == "Select Leave Type") {
                                    AppUtils.snackBar(
                                        'Please select leave type');
                                    return;
                                  }
                                  if (cupertinoTabBarValue == 2 &&
                                      selectedDate == endDate) {
                                    AppUtils.snackBar(
                                        'Please select valid date range');
                                    return;
                                  }
                                  if (_reasonController.text.isEmpty) {
                                    AppUtils.snackBar('Please enter reason');
                                    return;
                                  }

                                  await uploadData();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appthemColor,
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: isLoading.value
                              ? CircularProgressIndicator()
                              : Text(
                                  'APPLY',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum HalfDay { firstHalf, secondHalf }

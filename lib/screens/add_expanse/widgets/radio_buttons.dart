// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/finance_report_controller.dart';
import 'package:fineflow0/screens/add_expanse/widgets/image_select_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

class RadioButtons extends StatefulWidget {
  // final String reportName
  const RadioButtons({super.key});

  @override
  State<RadioButtons> createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
  final FinanceReportController controller1 =
      Get.put(FinanceReportController());

  final TextEditingController reportNameController = TextEditingController();
  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String dropdownValue = 'Food';
  bool isSwitched = false;

  final List<String> list = <String>[
    'Food',
    'Traveling',
    'Stationary',
    'Fine',
    'Other'
  ];

  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile(
          title: const ReusableText(
            text: 'Add manually',
            fontSize: 16,
          ),
          activeColor: Kdark,
          selectedTileColor: Kdark,
          value: 1,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
        RadioListTile(
          title: const ReusableText(
            text: 'Scan receipt',
            fontSize: 16,
          ),
          activeColor: Kdark,
          selectedTileColor: Kdark,
          value: 2,
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
        SizedBox(height: 16.h),
        if (_selectedValue == 1) _buildForm(),
        if (_selectedValue == 2) _buildScanButton(),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableText(
          text: "Report Title",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 8.h),
        ReusableTextfield(
          hintText: "Report title",
          controller: reportNameController,
        ),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Merchant Name",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 8.h),
        ReusableTextfield(
          hintText: "name",
          controller: merchantNameController,
        ),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Amount",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 8.h),
        ReusableTextfield(
          textInputType: TextInputType.number,
          hintText: "amount",
          prefixIcon: const Icon(
            LineIcons.indianRupeeSign,
            size: 20,
          ),
          controller: amountController,
        ),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Date",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
              dateController.text = formattedDate;
            }
          },
          child: AbsorbPointer(
            child: ReusableTextfield(
              hintText: "dd-mm-yyyy",
              prefixIcon: const Icon(
                LineIcons.calendar,
                size: 20,
              ),
              controller: dateController,
              textInputType: TextInputType.datetime,
            ),
          ),
        ),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Description",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 12.h),
        ReusableTextfield(
          hintText: "description",
          controller: descriptionController,
        ),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Category",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Kdark,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: DropdownButton<String>(
              iconDisabledColor: Kgray,
              dropdownColor: Koffwhite,
              value: dropdownValue,
              icon: const Icon(
                LineIcons.alternateArrowCircleDownAlt,
                color: Kdark,
              ),
              elevation: 16,
              style: const TextStyle(color: Kdark),
              underline: Container(
                height: 2,
                color: Colors.transparent,
              ),
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Transform.scale(
              scale: 0.85,
              child: Switch(
                inactiveThumbColor: Kwhite,
                inactiveTrackColor: Kgray,
                activeTrackColor: Kdark,
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ),
            const ReusableText(
              text: "Include VAT tax",
              color: Kdark,
              fontSize: 15,
            ),
          ],
        ),
        if (isSwitched)
          const ReusableTextfield(
            hintText: "Enter VAT amount",
          )
        else
          const SizedBox(height: 0),
        SizedBox(height: 12.h),
        const ReusableText(
          text: "Attach Receipt",
          color: Kdark,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        SizedBox(height: 12.h),
        const ImageSelectWidget(),
        SizedBox(height: 24.h),
        GestureDetector(
          onTap: () {
            try {
              // double amount = double.tryParse(amountController);
              controller1.addReport(
                  reportNameController.text.trim(),
                  merchantNameController.text.trim(),
                  double.tryParse(amountController.text) ?? 0.0,
                  dateController.text.trim(),
                  descriptionController.text.trim(),
                  dropdownValue);
            } catch (e) {
              Get.snackbar("Error", "Please check the entered data.");
              print("Form error: $e");
            }
          },
          child: Container(
            height: 45.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Kdark,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Kdark, width: 1.2),
            ),
            child: Center(
              child: ReusableText(
                text: "S A V E   E X P A N S E ",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Koffwhite,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }

  Widget _buildScanButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: DottedBorder(
            color: Kgray,
            strokeWidth: 1.7,
            dashPattern: const [10],
            radius: Radius.circular(12.r),
            child: Container(
              height: 145.h,
              color: KlightGray,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LineIcons.plusCircle,
                      size: 22.sp,
                      color: Kgray,
                    ),
                    SizedBox(width: 8.w),
                    const ReusableText(
                      text: "Upload Image",
                      color: Kgray,
                      fontWeight: FontWeight.w500,
                      letterSpace: 1.2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

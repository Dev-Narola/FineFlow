// ignore_for_file: depend_on_referenced_packages

import 'package:fineflow0/bottom_bar.dart';
import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/finance_report_controller.dart';
import 'package:fineflow0/services/storage/storage_services.dart';
import 'package:fineflow0/services/storage/storage_services_from_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';

class RadioButtons extends StatefulWidget {
  final String reportName;
  const RadioButtons({super.key, required this.reportName});

  @override
  State<RadioButtons> createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
  final imageUploadController = Get.put(StorageServices());
  final reportControllerFromCamera = Get.put(StorageServicesFromCamera());
  final FinanceReportController controller = Get.put(FinanceReportController());

  final TextEditingController merchantNameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String dropdownValue = 'Food';
  String typeValue = 'expense';
  bool isSwitched = false;
  bool isUploading = false;

  final List<String> list = <String>[
    'Food',
    'Traveling',
    'Stationary',
    'Fine',
    'Other'
  ];

  final List<String> typeList = <String>[
    'expense',
    'income',
  ];
  int _selectedValue = 0;

  String? uploadedImageUrl;

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
          prefixIcon: const Icon(LineIcons.indianRupeeSign, size: 20),
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
              dateController.text =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            }
          },
          child: AbsorbPointer(
            child: ReusableTextfield(
              hintText: "dd-mm-yyyy",
              prefixIcon: const Icon(LineIcons.calendar, size: 20),
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
          text: "Type",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.3),
              borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: typeValue,
              dropdownColor: Koffwhite,
              onChanged: (String? value) {
                setState(() {
                  typeValue = value!;
                });
              },
              items: typeList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        const ReusableText(
          text: "Category",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Kdark,
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1.3),
              borderRadius: BorderRadius.circular(12.r)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: dropdownValue,
              dropdownColor: Koffwhite,
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
        SizedBox(height: 10.h),
        Row(
          children: [
            Transform.scale(
              scale: 0.85,
              child: Switch(
                activeColor: Kdark,
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
              fontSize: 15,
            ),
          ],
        ),
        if (isSwitched) ReusableTextfield(hintText: 'tax'),
        SizedBox(height: 12.h),
        _buildImageUploader(),
        SizedBox(height: 18.h),
        GestureDetector(
          onTap: () async {
            try {
              await controller.addReport(
                widget.reportName,
                merchantNameController.text.trim(),
                double.parse(amountController.text),
                dateController.text.trim(),
                descriptionController.text.trim(),
                typeValue,
                dropdownValue,
              );
              Get.off(BottomBar());
            } catch (e) {
              Get.snackbar("Error", "Please check the entered data.");
            }
          },
          child: Container(
            height: 45.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Kdark,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: Kdark, width: 1.2),
            ),
            child: Center(
              child: ReusableText(
                text: "S A V E   E X P E N S E ",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Koffwhite,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableText(
          text: "Attach Receipt",
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Koffwhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(LineIcons.timesCircleAlt))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.0.h),
                      child: ReusableText(
                        text: "Upload image options",
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ReusableButton(
                      onTap: () async {
                        setState(() => isUploading = true);
                        String? imageUrl =
                            await reportControllerFromCamera.uploadImage();
                        if (imageUrl != null) {
                          setState(() {
                            uploadedImageUrl = imageUrl;
                            isUploading = false;
                          });
                        }
                        Get.back();
                      },
                      btnHeight: 45,
                      content: "Take Photo",
                    ),
                    SizedBox(height: 16.h),
                    ReusableButton(
                      onTap: () async {
                        setState(() => isUploading = true);
                        String? imageUrl =
                            await imageUploadController.uploadImage();
                        if (imageUrl != null) {
                          setState(() {
                            uploadedImageUrl = imageUrl;
                            isUploading = false;
                          });
                        }
                        Get.back();
                      },
                      btnHeight: 45,
                      content: "Choose From Gallery",
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: DottedBorder(
            color: Kgray,
            radius: Radius.circular(8.r),
            borderType: BorderType.RRect,
            dashPattern: [6, 4],
            child: Container(
              height: 35.h,
              decoration: BoxDecoration(
                  color: Koffwhite, borderRadius: BorderRadius.circular(12.r)),
              child: Center(
                child: isUploading
                    ? CircularProgressIndicator()
                    : uploadedImageUrl != null
                        ? Image.network(
                            uploadedImageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LineIcons.plusCircle, color: Kgray),
                              const ReusableText(
                                text: "Upload images",
                                color: Kgray,
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

  Widget _buildScanButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement scanning logic here
      },
      child: const Text("Scan Receipt"),
    );
  }
}

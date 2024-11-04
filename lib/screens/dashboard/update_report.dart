import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/common/reusable_textfield.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/update_report.dart';
import 'package:fineflow0/model/all_report_response/report_model.dart';
import 'package:fineflow0/services/storage/storage_services.dart';
import 'package:fineflow0/services/storage/storage_services_from_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';

class UpdateReport extends StatefulWidget {
  final ReportModel report;
  const UpdateReport({super.key, required this.report});

  @override
  State<UpdateReport> createState() => _UpdateReportState();
}

class _UpdateReportState extends State<UpdateReport> {
  final imageUploadController = Get.put(StorageServices());
  final ReportController reportController = Get.put(ReportController());
  final reportControllerFromCamera = Get.put(StorageServicesFromCamera());

  late String dropdownValue;
  bool isSwitched = false;

  final List<String> list = <String>[
    'Food',
    'Traveling',
    'Stationary',
    'Fine',
    'Other'
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController merchantController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController taxController = TextEditingController();

  String? uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.report.category ?? list[0];
    nameController.text = widget.report.name ?? '';
    merchantController.text = widget.report.merchantName ?? '';
    amountController.text = widget.report.amount.toString();
    dateController.text = widget.report.date ?? '';
    descriptionController.text = widget.report.description ?? '';
    taxController.text = widget.report.tax?.toString() ?? '0.0';
  }

  double _parseDouble(String value) {
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0; // Return a default value if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Koffwhite,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: AppBar(
            backgroundColor: Koffwhite,
            title: ReusableText(
              text: "Update Report",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpace: 1.3,
            ),
            scrolledUnderElevation: 0,
            elevation: 0,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 10.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  if (imageUploadController.isUploading.value) {
                    return const SizedBox(
                      height: 130,
                      width: 130,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        color: Kdark,
                        backgroundColor: Koffwhite,
                      ),
                    );
                  } else {
                    String displayedImageUrl =
                        imageUploadController.imageUrl.isNotEmpty
                            ? imageUploadController.imageUrl.last
                            : (reportControllerFromCamera.imageUrl.isNotEmpty
                                ? reportControllerFromCamera.imageUrl.last
                                : widget.report.billImage ?? '');

                    return Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 225.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.3),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Image.network(displayedImageUrl),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Koffwhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 15,
                                      right: 15,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          LineIcons.times,
                                          color: Kgray,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.0.w, vertical: 14.h),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 25.h),
                                          const ReusableText(
                                            text: "Attach Receipt",
                                            color: Kdark,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(height: 12.h),
                                          ReusableButton(
                                            onTap: () async {
                                              String? imageUrl =
                                                  await reportControllerFromCamera
                                                      .uploadImage();
                                              if (imageUrl != null) {
                                                uploadedImageUrl = imageUrl;
                                              }
                                              Get.back();
                                            },
                                            content: "Take Photo",
                                            btnHeight: 40.h,
                                            btnWidth: double.maxFinite,
                                            borderColor: Kgray,
                                          ),
                                          SizedBox(height: 12.h),
                                          ReusableButton(
                                            onTap: () async {
                                              String? imageUrl =
                                                  await imageUploadController
                                                      .uploadImage();
                                              if (imageUrl != null) {
                                                uploadedImageUrl = imageUrl;
                                              }
                                              Get.back();
                                            },
                                            content: "Choose From Gallery",
                                            btnHeight: 40.h,
                                            btnWidth: double.maxFinite,
                                            borderColor: Kgray,
                                          ),
                                          SizedBox(height: 12.h),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Kdark,
                              child: Icon(LineIcons.camera, color: Koffwhite),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
                SizedBox(height: 25.h),
                ReusableText(
                  text: "Report name",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
                ReusableTextfield(
                  controller: nameController,
                  hintText: "Enter report name",
                  prefixIcon: Icon(LineIcons.userCircleAlt),
                ),
                SizedBox(height: 10.h),
                ReusableText(
                  text: "Merchant name",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
                ReusableTextfield(
                  controller: merchantController,
                  prefixIcon: Icon(LineIcons.userCircleAlt),
                  hintText: "Enter merchant name",
                ),
                SizedBox(height: 10.h),
                ReusableText(
                  text: "Amount",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
                ReusableTextfield(
                  controller: amountController,
                  prefixIcon: Icon(LineIcons.indianRupeeSign),
                  hintText: "Enter amount",
                ),
                SizedBox(height: 10.h),
                ReusableText(
                  text: "Date",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
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
                SizedBox(height: 10.h),
                ReusableText(
                  text: "Category",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Kdark,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
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
                SizedBox(height: 24.h),
                ReusableButton(
                  onTap: () {
                    String imageToSend =
                        uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty
                            ? uploadedImageUrl!
                            : widget.report.billImage ?? '';
                    String reportName = nameController.text;
                    String merchantName = merchantController.text;
                    double amount = _parseDouble(amountController.text);
                    String date = dateController.text;
                    String description = descriptionController.text;
                    double tax = _parseDouble(taxController.text);
                    String bill_image = imageToSend;

                    reportController.updateReport(
                      widget.report.id!,
                      reportName,
                      merchantName,
                      amount,
                      date,
                      description,
                      dropdownValue,
                      bill_image,
                      tax,
                    );
                  },
                  content: "Update Report",
                  btnHeight: 48,
                  textColor: Koffwhite,
                  backgroundColor: Kdark,
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:fineflow0/common/reusable_button.dart';
import 'package:fineflow0/common/reusable_text.dart';
import 'package:fineflow0/constant/constant.dart';
import 'package:fineflow0/controller/update_user.dart';
import 'package:fineflow0/controller/user_controller.dart';
import 'package:fineflow0/services/storage/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<GetUserController>();
    final imageUploadController = Get.put(StorageServices());
    final updateUserController = Get.put(UpdateUserController());

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Pre-fill with user info
    nameController.text = userController.user.name ?? "";
    emailController.text = userController.user.email ?? "";

    String? uploadedImageUrl; // Store uploaded image URL

    return Scaffold(
      backgroundColor: Koffwhite,
      appBar: AppBar(
        title: const ReusableText(
          text: "Update Profile",
          fontSize: 22,
          color: Kdark,
          fontWeight: FontWeight.bold,
          letterSpace: 1.5,
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Koffwhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      // Show progress indicator if uploading, else show the image
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
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1.5),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: Image.network(
                              imageUploadController.imageUrl.isEmpty
                                  ? userController.user.user_image ?? ''
                                  : imageUploadController.imageUrl.last,
                              height: 130.h,
                              width: 130.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        );
                      }
                    }),
                    Positioned(
                      bottom: 2,
                      right: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Kdark,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            String? imageUrl =
                                await imageUploadController.uploadImage();
                            if (imageUrl != null) {
                              uploadedImageUrl = imageUrl;
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Icon(
                                LineIcons.camera,
                                color: Koffwhite,
                                size: 27,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 26.h),
              const ReusableText(
                text: "Name",
                fontSize: 17,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: const TextStyle(
                    color: Kgray,
                  ),
                  prefixIcon: const Icon(LineIcons.userCircleAlt, size: 24),
                  prefixIconColor: Kdark,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kgray, width: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kdark, width: 1.3),
                  ),
                ),
                cursorColor: Kdark,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Kdark),
              ),
              SizedBox(height: 16.h),
              const ReusableText(
                text: "Email",
                fontSize: 17,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "email",
                  hintStyle: const TextStyle(
                    color: Kgray,
                  ),
                  prefixIcon: const Icon(LineIcons.envelope),
                  prefixIconColor: Kdark,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kgray, width: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kdark, width: 1.3),
                  ),
                ),
                cursorColor: Kdark,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Kdark),
              ),
              SizedBox(height: 16.h),
              const ReusableText(
                text: "Password",
                fontSize: 17,
              ),
              SizedBox(height: 6.h),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(LineIcons.lock),
                  hintStyle: const TextStyle(
                    color: Kgray,
                  ),
                  prefixIconColor: Kdark,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kgray, width: 1.3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: const BorderSide(color: Kdark, width: 1.3),
                  ),
                ),
                cursorColor: Kdark,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Kdark),
              ),
              SizedBox(height: 46.h),
              ReusableButton(
                onTap: () async {
                  // Check if imageUrl is not empty before sending
                  String imageToSend =
                      uploadedImageUrl != null && uploadedImageUrl!.isNotEmpty
                          ? uploadedImageUrl!
                          : userController.user.user_image ?? '';

                  // Call updateUserController.updateUser with the image URL and other info
                  await updateUserController.updateUser({
                    "name": nameController.text,
                    "email": emailController.text,
                    "password": passwordController.text,
                    "user_image": imageToSend, // Only send valid image URL
                  });

                  // Refresh the user data after update
                  userController.getUser();
                },
                content: "Save Profile",
                textColor: Koffwhite,
                backgroundColor: Kdark,
                btnHeight: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

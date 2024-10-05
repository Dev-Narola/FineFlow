import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/constant.dart';

class TopBudgetContainer extends StatelessWidget {
  const TopBudgetContainer({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 70.h,
      width: (width / 2.3).w,
      decoration: BoxDecoration(
        color: Kdark,
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
    );
  }
}

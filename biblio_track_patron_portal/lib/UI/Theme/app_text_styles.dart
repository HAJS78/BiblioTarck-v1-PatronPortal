
import 'package:flutter/material.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles 
{
  AppTextStyles._();

 static TextStyle get appLogoPrimaryText => TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: AppColors.primary );
  static TextStyle get appLogoSecondaryText => TextStyle(fontSize:18.sp, fontWeight: FontWeight.bold, color: AppColors.accent);

  static TextStyle get heading => TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static TextStyle get title => TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.textPrimary);
  static TextStyle get subtitle => TextStyle(fontSize: 14.sp, color: AppColors.textSecondary);
  static  TextStyle get label => TextStyle(fontSize: 12.sp, color: AppColors.primary);
  static  TextStyle get body => TextStyle(fontSize: 13.sp, color: AppColors.textPrimary);
  
  static  TextStyle get linkText => TextStyle(fontSize: 12.sp, color: AppColors.primary);
  static TextStyle get button => TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static  TextStyle get errorMessage => TextStyle(fontSize: 13.sp, color:AppColors.error);
}
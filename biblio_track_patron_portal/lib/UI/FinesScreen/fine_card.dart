import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FineCard extends StatelessWidget
{

  final int fineRecordID;
  final int lateDays;
  final double amountDue;
  final DateTime dateAdded;
 
  final VoidCallback onPressingPay;

  const FineCard({super.key, required this.fineRecordID, required this.lateDays,required this.amountDue,required this.dateAdded,required this.onPressingPay});


@override
Widget build(BuildContext context)
{
  return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _infoRow("Fine ID", "$fineRecordID"),
            _infoRow("Late Days", "$lateDays"),
            _infoRow("Amount Due (\$)", amountDue.toStringAsFixed(2)),
            _infoRow("Date Added", "${dateAdded.day}-${dateAdded.month}-${dateAdded.year}"),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: onPressingPay, child: Text("Pay", style: AppTextStyles.button)),
            ),
          ],
        ),
      ),
    );
}

Widget _infoRow(String label,String value)
{
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.label),
        Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

}
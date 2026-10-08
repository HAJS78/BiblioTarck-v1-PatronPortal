import 'package:biblio_track_patron_portal/UI/ReservationScreen/reservation_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReservationView extends StatefulWidget
{
  final int bookRecordID;
  final String title;

  const ReservationView({super.key, required this.bookRecordID, required this.title});

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView>
{
  late ReservationViewModel reservationViewModel;
  final TextEditingController _cardNumberController = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async
      {
        reservationViewModel = context.read<ReservationViewModel>();
        await reservationViewModel.getBookCopyAvailability(widget.bookRecordID);
      },
    );
  }

  @override
  void dispose()
  {
    _cardNumberController.dispose();
    reservationViewModel.resetViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservation")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Book Title", style: AppTextStyles.label),
              Text(widget.title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),

              Consumer<ReservationViewModel>(
                builder: (context, viewModel, child)
                {
                  if (viewModel.isLoadingAvailability)
                  {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary,)),
                      ),
                    );
                  }

                  if (viewModel.availability.availableBookCopyID != null)
                  {
                    return Text(
                      "A copy is available and has been selected for reservation.",
                      style: AppTextStyles.body,
                    );
                  }
                 if (viewModel.availability.borrowedCopies.isNotEmpty)
                  {
                    return Text(
                      "Choose a borrowed copy to reserve:",
                      style: AppTextStyles.body,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        "No copies available right now.All copies are reserved.",
                        style: AppTextStyles.body,
                      ),
                      SizedBox(height: 8.h),RadioGroup<int>(groupValue:viewModel.selectedBookCopyID , onChanged:(value)=> viewModel.selectBorrowedCopy(value!), 
                      child :ListView.builder(shrinkWrap:true,itemCount:viewModel.availability.borrowedCopies.length,itemBuilder: (context,index)
                      {
                       return 
                          RadioListTile<int>(
                          value: viewModel.availability.borrowedCopies[index].bookCopyRecordID,
                          title: Text("Barcode: ${viewModel.availability.borrowedCopies[index].barcodeNumber}",style: AppTextStyles.body),
                          subtitle: Text(
                            "Expected return: ${viewModel.availability.borrowedCopies[index].expectedReturnDate.day}-${viewModel.availability.borrowedCopies[index].expectedReturnDate.month}-${viewModel.availability.borrowedCopies[index].expectedReturnDate.year}",
                          style: AppTextStyles.body),
                        );
                      }
                      )),
                    
                  ]);
                },
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: TextFormField(
                      controller: _cardNumberController,
                      decoration: InputDecoration(
                        labelText: 'Library Card Number',
                        hintText: 'Enter your 12 digits library card number',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => reservationViewModel.findLibraryCardByNumber(_cardNumberController.text),
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Consumer<ReservationViewModel>(
                    builder: (context, viewModel, child)
                    {
                      return Expanded(
                        flex: 1,
                        child: viewModel.libraryCardRecordID != null
                            ? const Icon(Icons.check, color: AppColors.success)
                            : const Icon(Icons.block, color: AppColors.error),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                child: Consumer<ReservationViewModel>(
                  builder: (context, viewModel, child)
                  {
                    return ElevatedButton(
                      onPressed: viewModel.canConfirm && !viewModel.isConfirming
                          ? () => _confirm(viewModel)
                          : null,
                      child: viewModel.isConfirming
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary,)),
                            )
                          :  Text('Confirm Reservation', style: AppTextStyles.button),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirm(ReservationViewModel viewModel) async
  {
    await viewModel.confirmReservation();

    if (mounted)
    {
      if (viewModel.confirmedReservationID != null)
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title:  Text('Reservation Confirmed',style: AppTextStyles.title),
            content: Text('Your reservation ID is #${viewModel.confirmedReservationID}.',style: AppTextStyles.body),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
            ],
          ),
        );
      }
      else
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Reservation Failed', style: AppTextStyles.title),
            content:  Text(viewModel.confirmReservationError ??'Please try again.', style: AppTextStyles.body),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
            ],
          ),
        );
      }
    }
  }
}
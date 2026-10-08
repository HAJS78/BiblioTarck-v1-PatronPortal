import 'package:biblio_track_patron_portal/UI/FinesScreen/fine_card.dart';
import 'package:biblio_track_patron_portal/UI/FinesScreen/fines_view_model.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_colors.dart';
import 'package:biblio_track_patron_portal/UI/Theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FinesView extends StatefulWidget
{
  final int memberRecordID;

  const FinesView({super.key,required this.memberRecordID});

  @override
  State<FinesView> createState() => _FinesViewState();
}



class _FinesViewState extends State<FinesView>
{
  late FinesViewModel finesViewModel;

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(

    (_)async
    {
       finesViewModel=context.read<FinesViewModel>();
       await finesViewModel.getUnpaidFines(widget.memberRecordID);
    }

    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text("Fines")),
      body: SafeArea(
        child: Consumer<FinesViewModel>(
          builder: (context, viewModel, child)
          {
            if(viewModel.isLoading)
            {
              return const Center(child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.primary));
            }

            if(viewModel.errorMessage!=null)
            {
              return Center(child: Text(viewModel.errorMessage!, style: AppTextStyles.errorMessage));
            }

            if(viewModel.unpaidFines.isEmpty)
            {
              return  Center(child: Text("You have no unpaid fines.",style:AppTextStyles.subtitle));
            }

            return ListView.builder(
              itemCount: viewModel.unpaidFines.length,
              itemBuilder: (context,index)
              {
                final fine = viewModel.unpaidFines[index];

                return FineCard(
                  fineRecordID: fine.fineRecordID,
                  lateDays: fine.lateDays,
                  amountDue: fine.amountDue,
                  dateAdded: fine.dateAdded,
                  
                  onPressingPay: ()=> payFine(fine.fineRecordID,fine.amountDue),
                );
              },
            );
          },
        ),
      ),
    );
  }


  Future<void> payFine(int fineRecordID,double amountDue)async
  {
   
    await context.push('/Pay',extra:{'memberRecordID':widget.memberRecordID,'fineRecordID':fineRecordID,'amountDue':amountDue});
     if (mounted) await finesViewModel.getUnpaidFines(widget.memberRecordID);
  }

}
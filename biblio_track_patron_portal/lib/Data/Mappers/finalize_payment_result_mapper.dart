import 'package:biblio_track_patron_portal/Data/Models/DTOs/finalize_payment_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/finalize_payment_result_model.dart';

class FinalizePaymentResultMapper
{
  static FinalizePaymentResultModel fromDTO(FinalizePaymentResultDTO dto)
  {
    return FinalizePaymentResultModel(
      success: dto.success,
      paymentRecordID: dto.paymentRecordID,
      stripePaymentRecordID: dto.stripePaymentRecordID,
      errorMessage: dto.errorMessage
    );
  }
}
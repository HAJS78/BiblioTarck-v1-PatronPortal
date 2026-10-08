class FinalizePaymentResultModel
{
  final bool success;
  final int? paymentRecordID;
  final int? stripePaymentRecordID;
  final String? errorMessage;

  FinalizePaymentResultModel({
    required this.success,
    this.paymentRecordID,
    this.stripePaymentRecordID,
    this.errorMessage
  });
}
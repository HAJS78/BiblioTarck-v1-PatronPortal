class FinalizePaymentResultDTO
{
  final bool success;
  final int? paymentRecordID;
  final int? stripePaymentRecordID;
  final String? errorMessage;

  FinalizePaymentResultDTO({
    required this.success,
    this.paymentRecordID,
    this.stripePaymentRecordID,
    this.errorMessage
  });

  static FinalizePaymentResultDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null)
    {
      return FinalizePaymentResultDTO(
        success: json['data']['success'],
        paymentRecordID: json['data']['paymentRecordID'],
        stripePaymentRecordID: json['data']['stripePaymentRecordID'],
       
      );
    }
    else
    {
      return FinalizePaymentResultDTO(
        success: false,
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}
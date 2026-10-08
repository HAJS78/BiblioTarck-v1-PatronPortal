class BorrowedCopyModel
{
  final int bookCopyRecordID;
  final String barcodeNumber;
  final DateTime expectedReturnDate;

  BorrowedCopyModel({
    required this.bookCopyRecordID,
    required this.barcodeNumber,
    required this.expectedReturnDate
  });
}
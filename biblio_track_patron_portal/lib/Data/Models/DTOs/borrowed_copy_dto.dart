class BorrowedCopyDTO
{
  final int bookCopyRecordID;
  final String barcodeNumber;
  final DateTime expectedReturnDate;

  BorrowedCopyDTO({
    required this.bookCopyRecordID,
    required this.barcodeNumber,
    required this.expectedReturnDate
  });

  static BorrowedCopyDTO fromJson(Map<String, dynamic> data)
  {
    return BorrowedCopyDTO(
      bookCopyRecordID: data['bookCopyRecordID'],
      barcodeNumber: data['barcodeNumber'],
      expectedReturnDate: DateTime.parse(data['expectedReturnDate']),
    );
  }

  static List<BorrowedCopyDTO> fromJsonList(List<dynamic> data)
  {
    List<BorrowedCopyDTO> copies = [];

    for (var item in data)
    {
      copies.add(BorrowedCopyDTO.fromJson(item));
    }

    return copies;
  }
}
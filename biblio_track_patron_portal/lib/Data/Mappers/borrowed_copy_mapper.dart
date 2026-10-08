import 'package:biblio_track_patron_portal/Data/Models/DTOs/borrowed_copy_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/borrowed_copy_model.dart';

class BorrowedCopyMapper
{
  static BorrowedCopyModel fromDTO(BorrowedCopyDTO dto)
  {
    return BorrowedCopyModel(
      bookCopyRecordID: dto.bookCopyRecordID,
      barcodeNumber: dto.barcodeNumber,
      expectedReturnDate: dto.expectedReturnDate,
    );
  }

  static List<BorrowedCopyModel> toModelList(List<BorrowedCopyDTO> list)
  {
    List<BorrowedCopyModel> copies = [];

    for (var c in list)
    {
      copies.add(BorrowedCopyMapper.fromDTO(c));
    }

    return copies;
  }
}
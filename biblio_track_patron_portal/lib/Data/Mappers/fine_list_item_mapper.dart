import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_list_item_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_list_item_model.dart';

class FineListItemMapper
{

// DTO → Domain Model (used in Repo after service call)
  static FineListItemModel fromDTO(FineListItemDTO dto)
  {

  return FineListItemModel(
    fineRecordID: dto.fineRecordID,
      lateDays: dto.lateDays,
      amountDue: dto.amountDue,
      dateAdded: dto.dateAdded,
    
    );


  }

static List<FineListItemModel> toFineModelList(List<FineListItemDTO> list)
{

   late List<FineListItemModel> fines=[];

   for(var f in list)
   {
      fines.add(FineListItemModel(fineRecordID: f.fineRecordID,  lateDays: f.lateDays, amountDue: f.amountDue, dateAdded: f.dateAdded));


   }

   return fines;

}

}
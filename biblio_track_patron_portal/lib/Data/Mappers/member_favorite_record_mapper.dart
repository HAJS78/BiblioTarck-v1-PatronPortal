import 'package:biblio_track_patron_portal/Data/Models/DTOs/member_favorite_record_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorite_record_model.dart';

class MemberFavoriteRecordMapper
{

  // DTO → Domain Model (used in Repo after service call)
  static MemberFavoriteRecordModel fromDTO(MemberFavoriteRecordDto dto) 
  {
    if(dto.errorMessage==null)
    {
    return MemberFavoriteRecordModel(
      recordID: dto.recordID,
      memberRecordID: dto.memberRecordID,
      bookRecordID: dto.bookRecordID,
      dateAdded: dto.dateAdded        
       
      
     
      
    );
    }
   else
   {
   return MemberFavoriteRecordModel(
      recordID: -1,
      memberRecordID: -1,
      bookRecordID: -1,
      dateAdded: DateTime.now(),
      errorMessage:dto.errorMessage
     
      );


   }

  }

  static MemberFavoriteRecordDto toDTO(MemberFavoriteRecordModel record)
  {

      return MemberFavoriteRecordDto(recordID: record.recordID, memberRecordID: record.memberRecordID, bookRecordID: record.bookRecordID, dateAdded: record.dateAdded);

  }


  static List<MemberFavoriteRecordModel> toBookModelList(List<MemberFavoriteRecordDto> list)
{

   late List<MemberFavoriteRecordModel> favoritesRecords=[];
  
   for(var r in list)
   {
   
    favoritesRecords.add(MemberFavoriteRecordModel(recordID: r.recordID, memberRecordID: r.memberRecordID, bookRecordID: r.bookRecordID, dateAdded: r.dateAdded));


   }

   return favoritesRecords;




}

  
  
}
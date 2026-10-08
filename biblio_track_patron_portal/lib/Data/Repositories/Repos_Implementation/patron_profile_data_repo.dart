
import 'package:biblio_track_patron_portal/Data/Mappers/patron_full_name_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_full_name_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_full_name_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_profile_data_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_profile_data_service.dart';

class PatronProfileDataRepo implements IPatronProfileDataRepo
 {
  final IPatronProfileDataService service;

  PatronProfileDataRepo ({required this.service});
 
 

  @override
   Future<PatronFullNameModel> getPatronFullName(int memberRecordID)async
   {
      PatronFullNameDTO dto= await service.getPatronFullName(memberRecordID); 
      PatronFullNameModel model=PatronFullNameMapper.fromDTO(dto);
       return model;

   }
 }
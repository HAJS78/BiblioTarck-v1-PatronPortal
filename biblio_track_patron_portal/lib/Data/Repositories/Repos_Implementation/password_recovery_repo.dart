import 'package:biblio_track_patron_portal/Data/Mappers/change_password_result_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/patron_lookup_by_email_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/change_password_result_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_email_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/change_password_result_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_email_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_password_recovery_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_password_recovery_service.dart';

class PasswordRecoveryRepo implements IPasswordRecoveryRepo
{
final IPasswordRecoveryService service;

  PasswordRecoveryRepo({required this.service});

 
 
 
  @override
  Future<ChangePasswordResultModel> changePassword(int memberRecordID,String newPassword) async 
  {
    ChangePasswordResultDTO dto=await service.changePassword(memberRecordID, newPassword);
    return ChangePasswordResultMapper.fromDTO(dto);
  }
 
 
  @override
  Future<PatronLookupByEmailModel> findPatronByEmail(String email) async
  {
 
    PatronLookupByEmailDTO dto = await service.findPatronByEmail(email);
    return PatronLookupByEmailMapper.fromDTO(dto);
    
  }

 


}
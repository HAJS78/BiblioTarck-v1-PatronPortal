import 'package:biblio_track_patron_portal/Data/Mappers/patron_lookup_by_library_card_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/sign_up_response_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Mappers/user_name_availability_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_library_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/user_name_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_lookup_by_library_card_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/sign_up_response_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/user_name_availability_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_registeration_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_registeration_service.dart';

class PatronRegisterationRepo implements IPatronRegisterationRepo
{
  final IPatronRegisterationService service;

 PatronRegisterationRepo({required this.service});



  @override
  Future<UserNameAvailabilityModel> isUserNameTaken(String usrName) async 
  {
       UserNameAvailabilityDTO dto=  await service.isUserNameTaken(usrName);
       return UserNameAvailabilityMapper.fromDTO(dto);
  }


   @override
  Future<PatronLookupByLibraryCardModel> findPatronByLibraryCardNumber(String libraryCardNumber) async
  {
    PatronLookupByLibraryCardDTO dto = await service.findPatronByLibraryCardNumber(libraryCardNumber);

      return PatronLookupByLibraryCardMapper.fromDTO(dto);
    

  }

   @override
   Future<SignUpResponseModel> updatePatronAccount(String username,String password,int memberRecordID)async
  {

  SignUpResponseDTO dto= await service.updatePatronAccount(username, password,memberRecordID);
  return SignUpResponseMapper.fromDTO(dto);


  }



}
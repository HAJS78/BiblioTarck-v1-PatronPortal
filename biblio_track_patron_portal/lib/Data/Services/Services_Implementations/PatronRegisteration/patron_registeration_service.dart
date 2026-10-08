import 'package:dio/dio.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_lookup_by_library_card_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/sign_up_response_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/user_name_availability_dto.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_registeration_service.dart';

class PatronRegisterationService implements IPatronRegisterationService
{
  final Dio dio;

  PatronRegisterationService({required this.dio});

  @override
  Future<UserNameAvailabilityDTO> isUserNameTaken(String usrName) async
  {
    final response = await dio.post(
      '/PatronRegisteration/UserNameAvailability',
      data: {'userName': usrName},
    );

    return UserNameAvailabilityDTO.fromJson(response.data);
  }

  @override
  Future<PatronLookupByLibraryCardDTO> findPatronByLibraryCardNumber(String libraryCardNumber) async
  {
    final response = await dio.post(
      '/PatronRegisteration/LibraryCard',
      data: {'libraryCardNumber': libraryCardNumber},
    );

    return PatronLookupByLibraryCardDTO.fromJson(response.data);
  }

  @override
  Future<SignUpResponseDTO> updatePatronAccount(String username, String password, int memberRecordID) async
  {
    final response = await dio.put(
      '/PatronRegisteration/Account',
      data: {'userName': username, 'password': password, 'memberRecordID': memberRecordID},
    );

    return SignUpResponseDTO.fromJson(response.data);
  }
}
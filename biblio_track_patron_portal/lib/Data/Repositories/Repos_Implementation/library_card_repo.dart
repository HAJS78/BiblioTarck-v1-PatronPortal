import 'package:biblio_track_patron_portal/Data/Mappers/library_card_lookup_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/library_card_lookup_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/library_card_lookup_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_library_card_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_library_card_service.dart';

class LibraryCardRepo implements ILibraryCardRepo
{
  final ILibraryCardService service;

  LibraryCardRepo({required this.service});

  @override
  Future<LibraryCardLookupModel> findLibraryCardByNumber(String libraryCardNumber) async
  {
    LibraryCardLookupDTO dto = await service.findLibraryCardByNumber(libraryCardNumber);
    return LibraryCardLookupMapper.fromDTO(dto);
  }
}
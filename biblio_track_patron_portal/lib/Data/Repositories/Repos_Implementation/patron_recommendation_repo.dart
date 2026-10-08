import 'package:biblio_track_patron_portal/Data/Mappers/patron_recommendation_mapper.dart';
import 'package:biblio_track_patron_portal/Data/Models/DTOs/patron_recommendation_dto.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/patron_recommendation_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_patron_recommendation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Services/Services_Interfaces/i_patron_recommendation_service.dart';

class PatronRecommendationRepo implements IPatronRecommendationRepo

 {
  final IPatronRecommendationsService service;

  PatronRecommendationRepo({required this.service});



@override
  Future<PatronRecommendationModel> getRecommendedBooks(int memberRecordID)async
  {
    PatronRecommendationDTO dto= await service.getRecommendedBooks(memberRecordID);

    PatronRecommendationModel model=PatronRecommendationMapper.fromDTO(dto);

     return model;

    
    
  }


 }
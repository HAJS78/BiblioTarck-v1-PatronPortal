import 'package:biblio_track_patron_portal/Data/Models/DTOs/book_card_dto.dart';

//recieves favorites list from end point
class MemberFavoritesDTO
{

final List<BookCardDTO> memberFavorites;
final String? errorMessage;

  MemberFavoritesDTO({required this.memberFavorites,this.errorMessage });

static MemberFavoritesDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null) 
    {
      return MemberFavoritesDTO(
      
        memberFavorites: BookCardDTO.fromJsonList( json['data']['favorites'])
        
      );
    }
    else 
    {
      return MemberFavoritesDTO(
       
        memberFavorites:List.empty(),
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
 

}
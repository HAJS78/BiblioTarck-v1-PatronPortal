import 'package:biblio_track_patron_portal/Data/Models/DTOs/fine_list_item_dto.dart';

class FineResultsDTO
{
  final List<FineListItemDTO> fines;
  final String? errorMessage;

  FineResultsDTO({
    required this.fines,
    this.errorMessage
  });

  static FineResultsDTO fromJson(Map<String, dynamic> json)
   {
    if (json['success'] == true && json['data'] != null)
    {
      return FineResultsDTO(
        fines: FineListItemDTO.fromJsonList(json['data']['fines'])
      );
    }
    else
    {
      return FineResultsDTO(
       fines: List.empty(),
        errorMessage: json['error'] ?? 'Unknown error');
    }
  }
}
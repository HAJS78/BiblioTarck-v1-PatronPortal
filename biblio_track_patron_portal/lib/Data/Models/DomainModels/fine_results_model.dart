import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_list_item_model.dart';

class FineResultsModel
{
  final List<FineListItemModel> fines;
  final String? errorMessage;

  FineResultsModel({
    required this.fines,
    this.errorMessage
  });
}
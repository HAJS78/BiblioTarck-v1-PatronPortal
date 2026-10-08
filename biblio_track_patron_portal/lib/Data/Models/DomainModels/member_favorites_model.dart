
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_card_model.dart';

class MemberFavoritesModel
{

final List<BookCardModel> memberFavorites;
final String? errorMessage;

  MemberFavoritesModel({required this.memberFavorites, this.errorMessage});
}
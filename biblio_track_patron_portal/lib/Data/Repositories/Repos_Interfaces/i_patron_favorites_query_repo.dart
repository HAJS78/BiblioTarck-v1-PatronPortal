import 'package:biblio_track_patron_portal/Data/Models/DomainModels/member_favorites_model.dart';

abstract class IPatronFavoritesQueryRepo 
{

 Future<MemberFavoritesModel> getFavorites(int memberRecordID);


}
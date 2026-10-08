import 'package:biblio_track_patron_portal/Data/Models/DomainModels/fine_list_item_model.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_fine_repo.dart';
import 'package:flutter/material.dart';

class FinesViewModel extends ChangeNotifier
{
  final IFineRepo fineRepo;

  FinesViewModel({required this.fineRepo});


  late List<FineListItemModel> _unpaidFines=[];
  List<FineListItemModel> get unpaidFines=>_unpaidFines;

  late bool _isLoading=false;
  bool get isLoading=>_isLoading;

  String? _errorMessage;
  String? get errorMessage=>_errorMessage;


  Future<void> getUnpaidFines(int memberRecordID)async
  {
    _isLoading=true;
    notifyListeners();

    var result = await fineRepo.getUnpaidFines(memberRecordID);

    _unpaidFines = result.fines;
    _errorMessage = result.errorMessage;

    _isLoading=false;
    notifyListeners();
  }


  

}
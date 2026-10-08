import 'package:biblio_track_patron_portal/Data/Models/DomainModels/book_copy_availability_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_confirmation_model.dart';
import 'package:biblio_track_patron_portal/Data/Models/DomainModels/reservation_model.dart';
//import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_book_reservation_repo.dart';
import 'package:biblio_track_patron_portal/Data/Repositories/Repos_Interfaces/i_library_card_repo.dart';
import 'package:flutter/material.dart';

class ReservationViewModel extends ChangeNotifier
{
  final IBookReservationRepo bookReservationRepo;
  final ILibraryCardRepo libraryCardRepo;

  ReservationViewModel({required this.bookReservationRepo, required this.libraryCardRepo});

  bool _isLoadingAvailability = false;
  bool get isLoadingAvailability => _isLoadingAvailability;

  BookCopyAvailabilityModel _availability = BookCopyAvailabilityModel(availableBookCopyID: null, borrowedCopies: []);
  BookCopyAvailabilityModel get availability => _availability;

  int? _selectedBookCopyID;
  int? get selectedBookCopyID => _selectedBookCopyID;

  Future<void> getBookCopyAvailability(int bookRecordID) async
  {
    _isLoadingAvailability = true;
    notifyListeners();

    _availability = await bookReservationRepo.getBookCopyAvailability(bookRecordID);

    // Auto-select if a copy is free right now; otherwise the patron must pick one.
    _selectedBookCopyID = _availability.availableBookCopyID;

    _isLoadingAvailability = false;
    notifyListeners();
  }

  void selectBorrowedCopy(int bookCopyRecordID)
  {
    _selectedBookCopyID = bookCopyRecordID;
    notifyListeners();
  }

  bool _isResolvingCard = false;
  bool get isResolvingCard => _isResolvingCard;

  int? _libraryCardRecordID;
  int? get libraryCardRecordID => _libraryCardRecordID;

  String? _cardLookupError;
  String? get cardLookupError => _cardLookupError;

  Future<void> findLibraryCardByNumber(String libraryCardNumber) async
  {
    _isResolvingCard = true;
    notifyListeners();

    var result = await libraryCardRepo.findLibraryCardByNumber(libraryCardNumber);

    if (result.libraryCardRecordID != -1)
    {
      _libraryCardRecordID = result.libraryCardRecordID;
      _cardLookupError = null;
    }
    else
    {
      _libraryCardRecordID = null;
      _cardLookupError = result.errorMessage;
    }

    _isResolvingCard = false;
    notifyListeners();
  }

  bool _isConfirming = false;
  bool get isConfirming => _isConfirming;

  int? _confirmedReservationID;
  int? get confirmedReservationID => _confirmedReservationID;

  bool get canConfirm => _libraryCardRecordID != null && _selectedBookCopyID != null;

  
  String? _confirmReservationError;
  String? get confirmReservationError => _confirmReservationError;
  
  Future<void> confirmReservation() async
  {
    if (!canConfirm) return;

    _isConfirming = true;
    notifyListeners();

    ReservationModel reservation = ReservationModel(
      reservationID: -1,
      libraryCardRecordID: _libraryCardRecordID!,
      bookCopyRecordID: _selectedBookCopyID!,
      reservationDate: DateTime.now(),
      reservationStatus: 1, // Confirmed
    );

        
    ReservationConfirmationModel resultModel = await bookReservationRepo.confirmReservation(reservation);
   _confirmedReservationID = resultModel.reservationID == -1 ? null : resultModel.reservationID; 
   _confirmReservationError = resultModel.errorMessage;

    _isConfirming = false;
    notifyListeners();
  }

  void resetViewModel()
  {
    _availability = BookCopyAvailabilityModel(availableBookCopyID: null, borrowedCopies: []);
    _selectedBookCopyID = null;
    _libraryCardRecordID = null;
    _cardLookupError = null;
    _confirmedReservationID = null;
    _confirmReservationError = null;
   
  }
}
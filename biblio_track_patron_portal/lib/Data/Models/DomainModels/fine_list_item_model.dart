class FineListItemModel
{
final int fineRecordID;
final int lateDays;
final double amountDue;
final DateTime dateAdded;


  FineListItemModel({required this.fineRecordID, required this.lateDays, required this.amountDue,required this.dateAdded});


FineListItemModel.isEmpty()
      : fineRecordID=-1,
        lateDays=0,
        amountDue=0,
        dateAdded=DateTime.now();
       

}
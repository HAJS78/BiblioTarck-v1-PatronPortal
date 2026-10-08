class FineListItemDTO
{
final int fineRecordID;
final int lateDays;
final double amountDue;
final DateTime dateAdded;


  FineListItemDTO ({required this.fineRecordID, required this.lateDays, required this.amountDue,required this.dateAdded});


FineListItemDTO.isEmpty()
      : fineRecordID=-1,
        lateDays=0,
        amountDue=0,
        dateAdded=DateTime.now();
        


static FineListItemDTO fromJson(Map<String, dynamic> data)
  {
    DateTime parsedDate;
    try
    {
      parsedDate = DateTime.parse(data['dateAdded']);
    }
    catch (e)
    {
      parsedDate = DateTime.now();
    }

    return FineListItemDTO(
      fineRecordID: data['fineRecordID'],
      lateDays: data['lateDays'],
      amountDue: (data['amountDue'] as num).toDouble(),
      dateAdded: parsedDate,
     
    );
  }


static List<FineListItemDTO> fromJsonList(List<dynamic> data)
  {
    List<FineListItemDTO> fines=[];

    for(var item in data)
    {
      fines.add(FineListItemDTO.fromJson(item));
    }

    return fines;
  }

}
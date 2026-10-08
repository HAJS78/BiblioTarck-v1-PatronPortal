class MemberNotificationMessageDTO
{

  final int notificationId;
  final String title; //not in the database as a field but you can derive from NotificationType field 
  final String body;  //Message field in db
  final String type; // "OverdueItems" or "ReservedItems"
  final bool isRead;

  MemberNotificationMessageDTO({required this.notificationId, required this.title, 
  required this.body, required this.type, required this.isRead});


static MemberNotificationMessageDTO fromJson(Map<String, dynamic> data) 
  {
    return MemberNotificationMessageDTO(
      notificationId: data['notificationId'],
      title: data['title'],
      body: data['message'],
      type:data['type'],
      isRead: data['isRead']);
    
     
    
  }


static List<MemberNotificationMessageDTO> fromJsonList( List<dynamic> data) 
  {
    List<MemberNotificationMessageDTO> messages=[];
    
    for(var item in data)
    {
      messages.add(MemberNotificationMessageDTO(
      notificationId: item['notificationId'],
      title: item['title'],
      body: item['body'],
      type:item['type'],
      isRead: item['isRead']));
    }

    return messages;
  }



  
}

  

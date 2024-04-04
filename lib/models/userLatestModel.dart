class UserNotificationModel{

  String id ;
  String content ;
  String date ;
  String fromId ;
  String notification_id;
  DateTime reg_id;
  String time ;
  String name ;
  String number ;
  String image ;
  String formatteddate;


  UserNotificationModel(this.id,this.content, this.date, this.fromId, this.notification_id, this.reg_id,
      this.time,this.name,this.number,this.image,this.formatteddate);
}






class UserLatestNotificationModel{

  String id ;
  String content ;
  String date ;
  String fromId ;
  String notification_id ;
  DateTime reg_id ;
  String time ;
  String name ;
  String number ;
  String image ;


  UserLatestNotificationModel(this.id,this.content, this.date, this.fromId, this.notification_id, this.reg_id,
      this.time,this.name,this.number,this.image);
}
class UserLatestNotificationDateModel{

  String dateFormat;
  DateTime date;

  UserLatestNotificationDateModel(this.dateFormat, this.date);
}
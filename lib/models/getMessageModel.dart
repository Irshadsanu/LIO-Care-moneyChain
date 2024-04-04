
class GetMessageModel{
  String messages;
  String messageImage;
  String link;
  String fromId;
  String fromName;
  String fromDocID;
  String time;
  String dayDate;
  bool isMoreClicked;
  String docID;


  GetMessageModel(this.messages,this.messageImage,this.link,this.fromId,this.fromName,this.fromDocID,this.time,this.dayDate,this.isMoreClicked,this.docID);
}

class MessageDateModel{
  String dateFormat;
  DateTime date;
  MessageDateModel(this.dateFormat,this.date);
}


class UserHelpModel {
  String name;
  String fromUserId;
  String number;
  String amount;
  String fromAmount;
  String toAmount;
  String status;
  String date;
  String grade;
  String tree;
  DateTime newDate;
  String paymentType;


  UserHelpModel(this.name,this.fromUserId,this.number,this.amount,this.fromAmount,this.toAmount,this.status,this.date,this.grade,this.tree,this.newDate,this.paymentType);
}

class GiveHelpModel{
  String name;
  String fromUserId;
  String number;
  String amount;
  String status;
  String grade;
  String tree;
  GiveHelpModel(this.name,this.fromUserId,this.number,this.amount,this.status,this.grade,this.tree,);
}

class AdminGiveHelpModel{

  String fromName;
  String fromNumber;
  String toName;
  String toNumber;
  String transactionID;
  String paymentDate;
  String paymentTime;
  DateTime paymentDateTime;
  String amount;
  String paymentType;
  String tree;
  AdminGiveHelpModel(this.fromName,this.fromNumber,this.toName,this.toNumber,
      this.transactionID,this.paymentDate,this.paymentTime,this.paymentDateTime,this.amount,this.paymentType,this.tree);

}

class AdminReferralLedgerModel{

  String grade;
  String tree;
  String fromName;
  String fromNumber;
  String toId;
  String fromId;
  String transactionID;
  String paymentTime;
  String amount;
  String toName;
  DateTime paymentTimeDateTime;
  String paymentTimeDateTimeString;
  AdminReferralLedgerModel(this.grade,this.tree,this.fromName,this.fromNumber
      ,this.toId,this.fromId,this.transactionID
      ,this.paymentTime,this.amount,this.toName,this.paymentTimeDateTime,this.paymentTimeDateTimeString);

}
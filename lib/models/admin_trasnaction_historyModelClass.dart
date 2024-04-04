class AdminsTransactionListModel{

   double amount;
  final String appVersion;
  final String fromUserId;
  final String grade;
  final String paymentMode;
  final String paymentStatus;
  final DateTime paymentTime;
  final String paymentType;
  final String toUserID;
  final String tree;
  final String username;
  final String phone;
  final String id;
  final String dateFormat;




  AdminsTransactionListModel(this.amount,this.appVersion,this.fromUserId,this.grade,this.paymentMode,
  this.paymentStatus,this.paymentTime,this.paymentType,this.toUserID,this.tree,this.username,this.phone,this.id,this.dateFormat,);
}

class TransactionDateModel{

  String dateFormat;
  DateTime date;

  TransactionDateModel(this.dateFormat, this.date);
}
class PrivilegeModel{

  String item;
  bool select;

  PrivilegeModel(this.item, this.select,);
}
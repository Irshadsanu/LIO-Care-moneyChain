class TransactionsModel {
  String name;
  String dateFormat;
  String time;
  String id;
  String number;
  String type;
  String amount;
  String flow;
  String tree;
  String grade;
  String installment;
  DateTime date;
  TransactionsModel(this.id,this.name,this.number,this.type,this.dateFormat,
      this.time,this.amount,this.flow,this.tree,this.grade,this.date,this.installment);
}
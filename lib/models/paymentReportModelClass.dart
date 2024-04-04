class PaymentReportModel{
  String id;
  double amount;
  DateTime dateTime;
  String date;
  String paymentType;
  String number;
  String status;
  String name;
  String time;
  String grade;
  String tree;
  String installment;


  PaymentReportModel(this.id, this.amount, this.dateTime,
      this.paymentType, this.number, this.status,this.date,
      this.name,this.time,this.grade,this.tree,this.installment
   );
}
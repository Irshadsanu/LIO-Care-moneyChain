import 'package:lio_care/models/usersList_model.dart';

class basic_treeModel{
  String login_user_id;
  String child_count;
  String direct_parent_id;
  String document_id;
  String grade;
  String member_id;
  String loginname;
  String loginphone;
  String step_id;
  List<usersListModel>parentdetailsList=[];
  basic_treeModel( this.login_user_id,this.child_count, this.direct_parent_id, this.document_id, this.grade, this.member_id,
   this.loginname, this.loginphone,this.step_id,this.parentdetailsList);
}
class TreeListModel{
String levelName;
bool color;
  TreeListModel(this.levelName,this.color);
}
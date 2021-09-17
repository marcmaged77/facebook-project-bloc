import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String code;
  final String message;


  const Failure({this.code = '', this.message = ''});



  @override
  bool? get stringify => true;

  //list of objects that will determine if two instances are equal
  //comparing the code and the messeage ( translate )
  @override
  List<Object?> get props => [code, message];


}
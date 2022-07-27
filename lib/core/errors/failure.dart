import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class AddDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class DeleteDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class NoDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}
class UpdateDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}



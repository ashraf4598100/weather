import 'package:equatable/equatable.dart';


class Params extends Equatable {
  final dynamic params;

  const Params({this.params});

  @override
  List<Object> get props => [params];
}

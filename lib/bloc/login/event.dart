import 'package:equatable/equatable.dart';
import 'package:fastfill/model/login/login_body.dart';

abstract class LoginEvent extends Equatable{

  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends LoginEvent {
  const InitEvent();
}

class LoginUserEvent extends LoginEvent{
  final LoginBody loginBody;

  const LoginUserEvent(this.loginBody);

  @override
  List<Object?> get props => [this.loginBody];
}
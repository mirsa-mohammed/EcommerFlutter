import 'package:bloc/bloc.dart';
import 'package:ecommerceapi/Api/User/UserApi.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserApi userApi;
  late String LoginRes;
  String LoginSuccess = "Login Successful";
  String LoginFail = "Incorrect Email or password!";

  LoginBloc(this.userApi) : super(LoginInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        LoginRes =
            await userApi.loginUser(event.uname, event.uemail, event.upass);

        if (LoginRes == LoginFail) {
          print('NotWroking if case');
        } else if (LoginRes == LoginSuccess) {
          print("=================$LoginRes");
          emit(LoginLoaded());
        }
        // switch (LoginRes) {
        //   case "Login Successful":
        //     emit(LoginLoaded());
        //     print("Swich Success");
        //     break;
        //
        //   case "Incorrect Email or password!":
        //     emit(LoginIncorrect());
        //     print("Swich Fail");
        // }

      } catch (e) {
        emit(LoginError());
        print('LoginBloc===========$e');
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:buty/Base/NetworkUtil.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/helpers/validator.dart';
import 'package:buty/models/login_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LogInBloc extends Bloc<AppEvent, AppState> with Validator {
  @override
  AppState get initialState => Start(null);

  final email = BehaviorSubject<String>();

  Function(String) get updateEmail => email.sink.add;

  Stream<String> get emailStream => email.stream.transform(emailValidator);

  final password = BehaviorSubject<String>();

  Function(String) get updatePassword =>password.sink.add;

  Stream<String> get passwordStream =>password.stream.transform(passwordValidator);

  String msg;

  Stream<bool> get submitChanged =>
      Rx.combineLatest2(passwordStream, passwordStream, (a, b) => true);

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    var netUtil = NetworkUtil();
    if (event is Click) {
      yield (Start(null));
      FormData data = FormData.fromMap({
        "email": email.value,
        "password": password.value,
      });
      yield Loading(null);
      var userResponee =
          await netUtil.post(UserResponse(), "users/auth/login", body: data);
      print("LogIn ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        SharedPreferenceManager preferenceManager = SharedPreferenceManager();
        preferenceManager.writeData(CachingKey.IS_LOGGED_IN, true);
        print(userResponee.user.accessToken);
        preferenceManager.writeData(
            CachingKey.AUTH_TOKEN, "${userResponee.user.accessToken }");
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      } else {
        yield Loading(null);
      }
    }
  }

  dispose() {
    email.close();
    password.close();
  }
}

final logInBloc = LogInBloc();

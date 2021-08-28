import 'package:bloc/bloc.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class LogInBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final email = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  Function(String) get updateEmail => email.sink.add;
  Function(String) get updatePassword => password.sink.add;

  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      print("1");
      yield (Start(null));
      yield Loading(null);
      print("2");
      var userResponee = await UserDataRepo.LOGIN(email.value, password.value);
      print("3");
      print("LogIn ResPonse : ${userResponee}"  );
      if (userResponee.status == true) {
        print("4");
        sharedPreferenceManager.writeData(CachingKey.IS_LOGGED_IN, true);
        sharedPreferenceManager.writeData(CachingKey.USER_ID, userResponee.user.id);
        sharedPreferenceManager.writeData(CachingKey.AUTH_TOKEN, "Bearer ${userResponee.user.accessToken}");
        sharedPreferenceManager.writeData(CachingKey.USER_NAME, userResponee.user.name);
        sharedPreferenceManager.writeData(CachingKey.EMAIL, userResponee.user.email);
        sharedPreferenceManager.writeData(CachingKey.MOBILE_NUMBER, userResponee.user.mobile);
        print("5");
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("6");
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }

  dispose() {
    email.close();
    password.close();
  }
}

final logInBloc = LogInBloc();

import 'package:bloc/bloc.dart';
import 'package:buty/Base/shared_preference_manger.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ForgetPasswordBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final email = BehaviorSubject<String>();

  Function(String) get updateEmail => email.sink.add;

  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await UserDataRepo.ForgetPassword(email.value);
      print("LogIn ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        sharedPreferenceManager.writeData(CachingKey.EMAIL, email.value);

        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }

  dispose() {
    email.close();
  }
}

final forgetPasswordBloc = ForgetPasswordBloc();

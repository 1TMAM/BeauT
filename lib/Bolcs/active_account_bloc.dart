import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ActiveAccount extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final code = BehaviorSubject<String>();

  Function(String) get updateEmail => code.sink.add;
  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await UserDataRepo.ActiveAccountFunction(code.value);
      print("LogIn ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }

  dispose() {
    code.close();
  }
}

final activeAccount = ActiveAccount();

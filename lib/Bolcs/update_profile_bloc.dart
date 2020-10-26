import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class UpdateProfileBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final name = BehaviorSubject<String>();
  final email = BehaviorSubject<String>();
  final mobile = BehaviorSubject<String>();

  final newPassword = BehaviorSubject<String>();
  final CurrentPassword = BehaviorSubject<String>();
  final NewpasswordConfirmation = BehaviorSubject<String>();

  Function(String) get updateEmail => email.sink.add;

  Function(String) get updateName => name.sink.add;

  Function(String) get updateMobile => email.sink.add;

  Function(String) get updateNewPassword => email.sink.add;

  Function(String) get updateCurrentPassword => email.sink.add;

  Function(String) get updateConfirmPassword => email.sink.add;
  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await UserDataRepo.UpdateProfileApi(
          name.value,
          email.value,
          newPassword.value,
          mobile.value,
          CurrentPassword.value,
          NewpasswordConfirmation.value);
      print("Update Response ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }
}

final updateProfileBloc = UpdateProfileBloc();

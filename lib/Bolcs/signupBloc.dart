import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/helpers/shared_preference_manger.dart';
import 'package:buty/repo/user_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SignUpBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final email = BehaviorSubject<String>();
  final name = BehaviorSubject<String>();
  final mobile = BehaviorSubject<String>();
  final password = BehaviorSubject<String>();
  final address = BehaviorSubject<String>();
  final lat = BehaviorSubject<double>();
  final lng = BehaviorSubject<double>();
  final number = BehaviorSubject<String>();
  final holderName = BehaviorSubject<String>();
  final cvv = BehaviorSubject<String>();
  final exp_date = BehaviorSubject<String>();

  Function(String) get updateEmail => email.sink.add;

  Function(String) get updateName => name.sink.add;

  Function(String) get updateMobile => mobile.sink.add;

  Function(String) get updatePassword => password.sink.add;

  Function(String) get updateAddress => address.sink.add;

  Function(double) get updateLat => lat.sink.add;

  Function(double) get updateLng => lng.sink.add;

  Function(String) get updateHolderName => holderName.sink.add;

  Function(String) get updateNumber => number.sink.add;

  Function(String) get updateCvv => cvv.sink.add;

  Function(String) get updateExpDate => email.sink.add;

  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield Loading(null);
      var response = await UserDataRepo.SIGNUP(
          holder_name: holderName.value,
          address: address.value,
          cvv: cvv.value,
          email: email.value,
          exp_date: exp_date.value,
          lat: lat.value,
          lng: lng.value,
          mobile: mobile.value,
          name: name.value,
          number: number.value,
          password: password.value);
      print("LogIn ResPonse" + response.msg);
      if (response.status == true) {
        print(response);
        yield Done(response);
      } else if (response.status == false) {
        print("Error Loading Event ");
        yield ErrorLoading(response);
      }
    }
  }
}

final signUpBloc = SignUpBloc();

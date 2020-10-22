import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/locations.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EditAddressBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final id = BehaviorSubject<int>();
  final address = BehaviorSubject<String>();

  final lat = BehaviorSubject<double>();

  final long = BehaviorSubject<double>();

  Function(int) get updateID => id.sink.add;

  Function(String) get updateAddress => address.sink.add;

  Function(double) get updateLat => lat.sink.add;

  Function(double) get updateLong => long.sink.add;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      var userResponee = await AddressRepo.EditAddress(
          id.value, address.value, lat.value, long.value);
      print("  Response" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }
}

final editAddressBloc = EditAddressBloc();

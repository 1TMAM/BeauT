import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CreateOrderBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);

  final date = BehaviorSubject<String>();
  final time = BehaviorSubject<String>();
  final location_type = BehaviorSubject<int>();
  final beautician_id = BehaviorSubject<int>();
  final services = BehaviorSubject<List<int>>();
  final person_num = BehaviorSubject<List<int>>();
  final payment_method = BehaviorSubject<int>();
  final coupon = BehaviorSubject<String>();
  final location_id = BehaviorSubject<int>();

  Function(String) get updateDate => date.sink.add;

  Function(String) get updateTime => time.sink.add;

  Function(int) get updateLocationType => location_type.sink.add;

  Function(int) get updateBeauticianId => beautician_id.sink.add;

  Function(List<int>) get updateServices => services.sink.add;

  Function(List<int>) get updatePersonNumber => person_num.sink.add;

  Function(int) get updatePaymentMethod => payment_method.sink.add;

  Function(String) get updateCopone => coupon.sink.add;

  Function(int) get updateLocationId => location_id.sink.add;
  String msg;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);

      print("Sellected Time ===========>" + date.value);
      // print(
      //     "Location Time  ===========>${location_type.value == 0 ? "Home " : "AT  Butyy Place"}");
      print("beautician_id  ===========> ${beautician_id.value}");
      print("servces   ===========> ${services.value}");
      print("persons   ===========> ${person_num.value}");
      print("payment_method ======> ${payment_method.value} ");
      print("coupon ======>  ${coupon.value}");
      print("location_id  ======> ${location_id.value}");
      print("In Bloc");

      var userResponee = await UserJourny.CreateReservation(
          date: date.value,
          time: time.value,
          location_id: location_id.value,
          beautician_id: beautician_id.value,
          services: services.value,
          person_num: person_num.value,
          payment_method: payment_method.value,
          coupon: coupon.value,
          location_type: location_type.value);
      print("Creating Order ResPonse" + userResponee.msg);
      if (userResponee.status == true) {
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }
}

final createOrderBloc = CreateOrderBloc();

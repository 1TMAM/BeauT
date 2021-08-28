import 'package:bloc/bloc.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CanselOrderBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);


  final order_id = BehaviorSubject<int>();
  final status = BehaviorSubject<int>();
  final beautician_id = BehaviorSubject<int>();
  final reason = BehaviorSubject<String>();
  final details = BehaviorSubject<String>();
  Function(int) get updateId => order_id.sink.add;
  Function(int) get updateStatus => status.sink.add;
  Function(int) get beauticianId => beautician_id.sink.add;
  Function(String) get cancel_reason => reason.sink.add;
  Function(String) get cancel_details => details.sink.add;

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is Click) {
      yield (Start(null));
      yield Loading(null);
      print("status : ${status.value}");
      var userResponee = await UserJourny.CanselOrderReason(
        order_id:   order_id.value ,
      //  status:status.value,
        beautician_id: beautician_id.value,
        cancel_reason: reason.value,
       // details: 'hhh'//details.value
      );
      print("AddCard  Response" + userResponee.status.toString());
      if (userResponee.status == true) {
        print("Donee");
        yield Done(userResponee);
      } else if (userResponee.status == false) {
        print("Message   ");
        yield ErrorLoading(userResponee);
      }
    }
  }
}

final canselOrderbloc = CanselOrderBloc();

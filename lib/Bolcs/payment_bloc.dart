import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/Payment/beautician_avaliable_time_model.dart';
import 'package:buty/repo/cards_repo.dart';
import 'package:buty/repo/payment_repo.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PaymentBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final BehaviorSubject<BeauticianAvaliableTimeModel> _subject = BehaviorSubject<BeauticianAvaliableTimeModel>();
  @override
  get subject {
    return _subject;
  }


  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    var ress;
    if (event is BeauticianTimesEvent) {
      yield Loading(null,indicator: 'beautician_time');
      ress = await paymentRepo.get_beautician_avaliable_time();
      print("beautician times   : ${ress}");
      if (ress.status == true) {
        _subject.sink.add(ress);
        yield Done(ress,indicator: 'beautician_time');
      }else{
        yield ErrorLoading(ress,indicator: 'beautician_time');
      }
    }
  }
}

final payment_bloc = PaymentBloc();

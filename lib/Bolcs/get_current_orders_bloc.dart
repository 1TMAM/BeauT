import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/repo/user_journy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:buty/models/current_ordera_model.dart';

class CurrentOrdersBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Start(null);
  final type = BehaviorSubject<String>();

  Function(String) get updateType => type.sink.add;


  final BehaviorSubject<CurrentOrdersResponse> _subject = BehaviorSubject<CurrentOrdersResponse>();
  @override
  get subject {
    return _subject;
  }

  final BehaviorSubject<CurrentOrdersResponse> _fnished_reservations_subject = BehaviorSubject<CurrentOrdersResponse>();
  @override
  get fnished_reservations_subject {
    return _fnished_reservations_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is CurrentReservatiosnEvent) {
      yield Loading(null);
      print("current 1");
      var ress = await UserJourny.GETCURRENTORDERS();
   /*   ress = updateType == "currernt"
          ? await UserJourny.GETCURRENTORDERS()
          : await UserJourny.GETDONEORDERS();*/
      print("ress : $ress" );
      print("current 1");

      _subject.sink.add(ress);
      yield Done(ress);
    }else  if (event is FinishedReservatiosnEvent) {
      yield Loading(null);
      print("current 1");
      var ress = await UserJourny.GETDONEORDERS();
      print("ress : $ress" );
      _fnished_reservations_subject.sink.add(ress);
      yield Done(ress);
    }
  }
}

final currentOrdersBloc = CurrentOrdersBloc();

import 'package:bloc/bloc.dart';
import 'package:demo_valorant/features/home/domain/use_cases/home_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _useCase;

  HomeBloc(this._useCase) : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
  }

  Future<void> _onHomeStarted(
    HomeStarted event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final agents = await _useCase.getAgents();
      emit(HomeLoaded(agents));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

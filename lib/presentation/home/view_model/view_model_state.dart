class HomeViewModelState {
  final bool isFirstStart;

  HomeViewModelState(this.isFirstStart);

  HomeViewModelState copyWith(bool isFirstStart) {
    return HomeViewModelState(isFirstStart);
  }
}

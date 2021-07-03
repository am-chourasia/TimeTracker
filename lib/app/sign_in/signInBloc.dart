import 'dart:async';

class SignInBloc {
  final StreamController<bool> _isLoading = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoading.stream;

  void setIsLoading(bool isLoading) {
    // _isLoading.sink.add(isLoading);
    _isLoading.add(isLoading);
  }

  void dispose() {
    _isLoading.close();
  }
}

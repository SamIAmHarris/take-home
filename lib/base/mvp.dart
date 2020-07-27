abstract class BaseView<T> {}

abstract class BasePresenter {
  init();
}

class BaseCallException {
  final String cause;

  BaseCallException(this.cause);
}

enum ScreenState { LOADING, CONTENT, ERROR }

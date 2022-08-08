enum AppPage {
  landing('/landing',''),
  error('/error', ''),
  login('/login', ''),
  root('/', ''),
  tab1('/tab1', ''),
  tab2('/tab2', ''),
  tab3('/tab3', ''),
  tab4('/tab4', ''),
  detail1('detail/:id', 'id');

  const AppPage(this.path, this.params);
  final String path;
  final String params;
}

/*
extension AppPageExtension on AppPage{
  String get path{
    switch(this){
      case AppPage.landing:
        return '/landing';
      case AppPage.error:
        return '/error';
      case AppPage.root:
        return '/';
      case AppPage.tab1:
        return '/tab1_page';
      case AppPage.detail1:
        return 'detail/:id';
      default:
        return '/';
    }
  }

  /// return parameters from route path
  /// https://gorouter.dev/parameters

  String get params{
    switch(this){
      case AppPage.detail1:
        return 'id';
      default:
        return '';
    }


  }



}*/

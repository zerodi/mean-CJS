# Global service for global variables
angular
  .module 'mean.system'
  .factory 'Global', [ ->
    _this = @;
    _this._data =
      user: window.user
      authenticated: !!window.user

    _this._data
  ] 
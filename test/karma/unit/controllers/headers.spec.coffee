(->
  describe "MEAN controllers", ->
    describe "HeaderController", ->

      # Load the controllers module
      beforeEach module("mean")
      scope = undefined
      HeaderController = undefined
      beforeEach inject(($controller, $rootScope) ->
        scope = $rootScope.$new()
        HeaderController = $controller("HeaderController",
          $scope: scope
        )
        return
      )
      it "should expose some global scope", ->
        expect(scope.global).toBeTruthy()
        return

      return

    return

  return
)()
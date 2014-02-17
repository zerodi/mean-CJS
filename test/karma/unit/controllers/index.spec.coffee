(->
  describe "MEAN controllers", ->
    describe "IndexController", ->

      # Load the controllers module
      beforeEach module("mean")

      scope = undefined
      IndexController = undefined

      beforeEach inject ($controller, $rootScope) ->
        scope = $rootScope.$new()

        IndexController = $controller "IndexController",
          $scope: scope

      it "should expose some global scope", ->
        expect(scope.global).toBeTruthy()
)()
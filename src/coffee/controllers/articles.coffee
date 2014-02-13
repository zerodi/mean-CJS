angular
  .module 'mean.articles'
  .controller 'ArticlesController', [
      '$scope'
      '$routeParams'
      '$location'
      'Global'
      'Articles'
      ($scope, $routeParams, $location, Global, Articles) ->
        $scope.global = Global

        $scope.create = ->
          article = new Articles
            title: @title
            content: @content
          article.$save (response) ->
            $location.path 'articles/' + response._id

          @title = ''
          @content = ''

        $scope.remove = (article) ->
          if article
            article.$remove()

            for i of $scope.articles
              $scope.articles.splice i, 1 if $scope.articles[i] is article
          else
            $scope.article.$remove()
            $location.path 'articles'

        $scope.update = ->
          article = $scope.article
          unless article.updated
              article.updated = []
          article.updated.push new Date().getTime()

          article.$update ->
            $location.path 'articles' + article._id

        $scope.find = ->
          Articles.query (articles) ->
            $scope.articles = articles

        $scope.findOne = ->
          Articles.get
            articleId: $routeParams.articleId
          , (article) ->
              $scope.article = article
  ]
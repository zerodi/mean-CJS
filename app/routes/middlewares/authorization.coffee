###
  Generic require login routing meddleware
###
exports.requireLogin = (req, res, next) ->
  return res.send 401, 'User in not authorized' unless req.isAuthenticated()
  next()

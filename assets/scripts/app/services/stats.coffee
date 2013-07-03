window.myApp.factory('Stats', ['$resource', ($resource)->
    
    # return $resource('http://:url/:statId.json',{url: "swally.herokuapp.com/stats" , statId: '@id'}, {getById: {method: 'GET'}})
    return $resource('https://api.mongolab.com/api/1/databases/heroku_app12577889/collections/Stat?apiKey=6Utcl_PXWwHq64dribp2m8XA2pOAlLnG')
])
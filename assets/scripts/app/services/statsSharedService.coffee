window.myApp.factory('StatsShared', ['$resource', 'Stats', ($resource , Stats)->
    statsShared = {}

    statsShared.ranking_tab = []
    statsShared.allStatsByCity = {}

    statsShared.getStats = (callback, refresh=false)->
        if statsShared.ranking_tab.length == 0 || refresh
            statsShared.allStats = Stats.query(()->
                for k, stat of statsShared.allStats
                    if statsShared.allStatsByCity[stat.city]
                        statsShared.allStatsByCity[stat.city]['swallow']+= stat.swallow
                    else
                        statsShared.allStatsByCity[stat.city] = 
                            location: 
                                lat: stat.lat
                                long: stat.long
                            city: stat.city
                            swallow : stat.swallow

                for city, stat of statsShared.allStatsByCity
                    statsShared.ranking_tab.push(stat)


                statsShared.ranking_tab.sort((a,b)->
                    if a.swallow > b.swallow
                        return 1
                    if a.swallow < b.swallow
                        return -1

                    return 0
                )

                callback()
            )

        else
            callback()


    statsShared
])
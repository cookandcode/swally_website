window.myApp.factory('StatsShared', ['$resource', 'Stats', ($resource , Stats)->
    statsShared = {}

    statsShared.ranking_tab = []
    statsShared.allStatsByCity = {}
    ratio_verre = 3
    ratio_cuite = 20
    ratio_coit = 30
    ratio_degeulis = 50

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
                            verre: 0
                            cuite: 0
                            coit: 0
                            degeulis: 0

                for city, stat of statsShared.allStatsByCity
                    stat.verre = parseInt(stat.swallow / ratio_verre * 100) / 100
                    stat.cuite = parseInt(stat.swallow / ratio_cuite * 100) / 100
                    stat.coit = parseInt(stat.swallow / ratio_coit * 100) / 100
                    stat.degueulis = parseInt(stat.swallow / ratio_degeulis * 100) / 100
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
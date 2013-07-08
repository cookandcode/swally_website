window.myApp.controller('statController', ['Stats','StatsShared', '$scope', (Stats, StatsShared, $scope)->
    # $scope.allStats = Stats.query(()->

    #     mapOptions = {
    #       center: new google.maps.LatLng(46.75984, 1.738281),
    #       zoom: 5,
    #       mapTypeId: google.maps.MapTypeId.ROADMAP
    #     };
    #     map = new google.maps.Map(document.getElementById("map"),mapOptions);

    #     tab_stats = {}
    #     # COUNT THE NUMBER OF SWALLOW DRUNK IN THE CITY
    #     for k, stat of $scope.allStats
    #         if tab_stats[stat.city]
    #             tab_stats[stat.city]['swallow']+= stat.swallow
    #         else
    #             tab_stats[stat.city] = 
    #                 location: 
    #                     lat: stat.lat
    #                     long: stat.long
    #                 city: stat.city
    #                 swallow : stat.swallow


    #     # PLACE THE MARKER ON THE MAP
    #     for city, stat of tab_stats
    #         myLatlng = new google.maps.LatLng(stat.location.lat,stat.location.long);

    #         infowindow = new google.maps.InfoWindow({
    #             content: stat.swallow+' gorgee(s) bue(s) a '+city
    #         });

    #         marker = new google.maps.Marker({
    #           position: myLatlng,
    #           map: map,
    #           clickable: true,
    #           animation: google.maps.Animation.DROP,
    #         })

    #         google.maps.event.addListener(marker, 'click', ()->
    #           infowindow.open(map, marker);
    #         )

    # )
    
    StatsShared.getStats(()->
        $scope.allStats = StatsShared.allStatsByCity
        $scope.ranked_cities = StatsShared.ranking_tab

        console.log $scope.ranked_cities
        mapOptions = {
          center: new google.maps.LatLng(46.75984, 1.738281),
          zoom: 5,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map"),mapOptions);


        marker = {}
        infowindow = {}
        i = -1
        # PLACE THE MARKER ON THE MAP
        for city, stat of $scope.allStats
            i++

            myLatlng = new google.maps.LatLng(stat.location.lat,stat.location.long);

            text = stat.swallow+' gorgee(s) bue(s) <br/> soit '+stat.verre+' verre, <br/> soit '+stat.cuite+' cuite, <br/> soit '+stat.coit+' coit, <br/> soit '+stat.degueulis+' degueulis, a '+city
            infowindow[i] = new google.maps.InfoWindow({
                content: text
            });

            marker[i] = new google.maps.Marker({
              position: myLatlng,
              map: map,
              clickable: true,
              animation: google.maps.Animation.DROP, 
            })

            do (i)->
                google.maps.event.addListener(marker[i], 'click', ()->
                    infowindow[i].open(map, marker[i]);
                    true
                )


        true

    )


])
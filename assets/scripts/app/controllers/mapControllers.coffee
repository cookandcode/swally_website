window.myApp.controller('mapController', ['Stats','$scope', (Stats, $scope)->
    $scope.allStats = Stats.query(()->

        mapOptions = {
          center: new google.maps.LatLng(46.75984, 1.738281),
          zoom: 5,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map"),mapOptions);

        tab_stats = {}
        for k, stat of $scope.allStats
            lat_plus_long = stat.lat + stat.long
            if tab_stats[lat_plus_long]
                tab_stats[lat_plus_long]++
                console.log 'OK'
            else
                tab_stats[lat_plus_long] = 1
                console.log 'NOT OK'

            if parseInt(k) == 10
                myLatlng = new google.maps.LatLng(stat.lat,stat.long);

                marker = new google.maps.Marker({
                  position: myLatlng,
                  map: map,
                  animation: google.maps.Animation.DROP,
                  title:"Hello World!"
                });

    )



])
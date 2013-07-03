// Generated by CoffeeScript 1.6.3
(function() {
  window.myApp.controller('mapController', [
    'Stats', '$scope', function(Stats, $scope) {
      return $scope.allStats = Stats.query(function() {
        var city, infowindow, k, map, mapOptions, marker, myLatlng, stat, tab_stats, _ref, _results;
        mapOptions = {
          center: new google.maps.LatLng(46.75984, 1.738281),
          zoom: 5,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map"), mapOptions);
        tab_stats = {};
        _ref = $scope.allStats;
        for (k in _ref) {
          stat = _ref[k];
          if (tab_stats[stat.city]) {
            tab_stats[stat.city]['swallow'] += stat.swallow;
          } else {
            tab_stats[stat.city] = {
              location: {
                lat: stat.lat,
                long: stat.long
              },
              city: stat.city,
              swallow: stat.swallow
            };
          }
        }
        _results = [];
        for (city in tab_stats) {
          stat = tab_stats[city];
          myLatlng = new google.maps.LatLng(stat.location.lat, stat.location.long);
          infowindow = new google.maps.InfoWindow({
            content: stat.swallow + ' gorgee(s) bue(s) a ' + city
          });
          marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            clickable: true,
            animation: google.maps.Animation.DROP
          });
          _results.push(google.maps.event.addListener(marker, 'click', function() {
            return infowindow.open(map, marker);
          }));
        }
        return _results;
      });
    }
  ]);

}).call(this);

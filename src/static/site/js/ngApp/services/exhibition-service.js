Exhibition.factory('ExhibitionService', function ($http, $q) {
    var api_url = "/exhibitions/api/apps/";
    return {
        get: function (app_id) {
            var url = api_url + app_id + "/";
            var defer = $q.defer();
            $http({method: 'GET', url: url}).
                success(function (data, status, headers, config) {
                    console.log(data);
                    defer.resolve(data);
                })
                .error(function (data, status, headers, config) {
                    defer.reject(status);
                });
            return defer.promise;
        },
        list: function () {
            var defer = $q.defer();
            $http({method: 'GET', url: api_url}).
                success(function (data, status, headers, config) {
                    console.log(data);
                    defer.resolve(data);
                }).error(function (data, status, headers, config) {
                    defer.reject(status);
                });
            return defer.promise;
        },
        update: function (app) {
            var url = api_url + app.id + "/";
            var defer = $q.defer();
            $http({method: 'PUT',
                url: url,
                data: app}).
                success(function (data, status, headers, config) {
                    defer.resolve(data);
                }).error(function (data, status, headers, config) {
                    defer.reject(status);
                });
            return defer.promise;
        },
        save: function (app) {
            console.log("save", app, api_url);
            var url = api_url;
            var defer = $q.defer();
            $http({method: 'POST',
                url: url,
                data: app}).
                success(function (data, status, headers, config) {
                    console.log("success", data);
                    defer.resolve(data);
                }).error(function (data, status, headers, config) {
                    defer.reject(status);
                });
            return defer.promise;
        },
    }
});

function fn() {
  var config = {
    baseApiUrl: 'https://petstore.swagger.io/v2/pet/',
  };
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  return config;
}
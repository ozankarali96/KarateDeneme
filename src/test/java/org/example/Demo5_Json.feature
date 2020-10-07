Feature: Karate Dss

  Background:

    * url 'https://jsonplaceholder.typicode.com'
  @GetScenario @TypicodeGet @Get
    Scenario: get all users and then get the first user by id
      Given path 'users/1'
      When method get
      Then status 200
     * def JsonResponse = read('users1.json')
     Then print JsonResponse

     And match response == JsonResponse
     And match response.id == 1
     And match response.address.street == 'Kulas Light'
     And match response.address.geo.lat == '-37.3159'


     * def job_code = response.address.job_code
     And match job_code == null


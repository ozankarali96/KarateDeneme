Feature: Karate Dss

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * header Accept = 'application/json'

    @GetScenario @TypicodeGet @Get
    Scenario: get all users and then get the first user by id
    Given path 'users'
    When method get
    Then status 200
    Then print response
    Then print responseTime
    * def timeJava = Java.type('Features.time')
    * def myCurrentTime = new timeJava().myTime()
    Then print 'Test çalıştırılma zamanı :', myCurrentTime, 've Test süresi :', responseTime/1000, 'saniyedir.'


   @PostScenario @TypicodePost @Post
   Scenario: create a user and then get it by id
    * def user = read('user1.json')
    Given path '/posts/1'
    And request user
    When method put
    Then status 404
    * def timeJava = Java.type('Features.time')
    * def myCurrentTime = new timeJava().myTime()
    Then print 'Test çalıştırılma zamanı :', myCurrentTime, 've Test süresi :', responseTime/1000, 'saniyedir.'



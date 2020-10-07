Feature:
  Scenario:
    Given url 'https://reqres.in/api/users/2'
    When method get
    Then status 200
    Then print response


  Scenario: QUESTİON 2 ---- Verify that title and author are required fields.
    Given url 'https://reqres.in/api/users/2'
    When method put
    Then status 200
    Then print response
    Then print responseTime


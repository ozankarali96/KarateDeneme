Feature:

  Background:

    # * def expectedOutput = read('users2.json')
    # * def expectedOutput2 = read('users3.json')
    * def expectedOutput = read('../Features/users2.json')

    Scenario: 
      Given url 'https://reqres.in/api/users/1'
      When method get
      Then status 200
      Then print response
      And match response == expectedOutput[0]
      # Burada [0] verme işine dikkat et. Altta da [1] veriyorsun. Böylelikle JSON'da seçim yapıyorsun.

    Scenario:
      Given url 'https://reqres.in/api/users/2'
      When method get
      Then status 200
      Then print response
      And match response == expectedOutput[1]

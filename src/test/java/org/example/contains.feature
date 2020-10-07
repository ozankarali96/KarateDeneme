Feature: contains
  Background:

    Scenario: contains olayı
      ##TODO: incelenecek
      Given def cat =
        """
        {
        name: 'Billie',
        kittens: [
        { id: 23, name: 'Bob' },
        { id: 42, name: 'Wild' }
          ]
        }
        """

      # normal 'equality' match. note the wildcard '*' in the JsonPath (returns an array)
      Then match cat.kittens[*].id == [23, 42]

      # when inspecting a json array, 'contains' just checks if the expected items exist
      # and the size and order of the actual array does not matter
      Then match cat.kittens[*].id contains 23
      Then match cat.kittens[*].id contains [42]
      Then match cat.kittens[*].id contains [23, 42]
      Then match cat.kittens[*].id contains [42, 23]

      # the .. operator is great because it matches nodes at any depth in the JSON "tree"
      Then match cat..name == ['Billie', 'Bob', 'Wild']

      # and yes, you can assert against nested objects within JSON arrays !
      Then match cat.kittens contains [{ id: 42, name: 'Wild' }, { id: 23, name: 'Bob' }]

      # ... and even ignore fields at the same time !
      Then match cat.kittens contains { id: 42, name: '#string' }

      Scenario: contains olayı 2
        * def data = { foo: [1, 2, 3] }
        * match data.foo contains 1
        * match data.foo contains [2]
        * match data.foo contains [3, 2]
        * match data.foo contains only [3, 2, 1]
        * match data.foo contains only [2, 3, 1]
        # this will fail
        # * match data.foo contains only [2, 3]


      Scenario: match contains only olayı
        * def data = { foo: [1, 2, 3] }
        * match data.foo contains any [9, 2, 8]

        * def data2 = { a: 1, b: 'x' }
        * match data2 contains any { b: 'x', c: true }

      Scenario: match each 1
        * def data = { foo: [{ bar: 1, baz: 'a' }, { bar: 2, baz: 'b' }, { bar: 3, baz: 'c' }]}

        * match each data.foo == { bar: '#number', baz: '#string' }

        # and you can use 'contains' the way you'd expect
        * match each data.foo contains { bar: '#number' }
        * match each data.foo contains { bar: '#? _ != 4' }

        # some more examples of validation macros
        * match each data.foo contains { baz: "#? _ != 'z'" }
        * def isAbc = function(x) { return x == 'a' || x == 'b' || x == 'c' }
        * match each data.foo contains { baz: '#? isAbc(_)' }

        # this is also possible, see the subtle difference from the above
        * def isXabc = function(x) { return x.baz == 'a' || x.baz == 'b' || x.baz == 'c' }
        * match each data.foo == '#? isXabc(_)'

      Scenario: match each 2
        Given def json =
         """
          {
          "hotels": [
          { "roomInformation": [{ "roomPrice": 618.4 }], "totalPrice": 618.4  },
          { "roomInformation": [{ "roomPrice": 679.79}], "totalPrice": 679.79 }
          ]
          }
          """
        Then match each json.hotels contains { totalPrice: '#? _ == _$.roomInformation[0].roomPrice' }
        # when validation logic is an 'equality' check, an embedded expression works better
        Then match each json.hotels contains { totalPrice: '#(_$.roomInformation[0].roomPrice)' }
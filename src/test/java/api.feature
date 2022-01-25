Feature: https://petstore.swagger.io/ API test

  Background:
    * url baseApiUrl

  Scenario Outline: findByStatus method test

    Given path 'findByStatus'
    And param status = <status>
    When method GET
    Then status 200
    And match each response contains {"status": <status>}

    Examples:
      | status      |
      | 'available' |
      | 'pending'   |
      | 'sold'      |


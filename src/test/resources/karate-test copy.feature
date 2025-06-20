
@REQ_HU-1234 @HU1234 @marvel_characters_management @marvel_characters_api @Agente2 @E2 @iniciativa_marvel @automation_with_copilotFeature: Test de API súper simple

  Background:
    * configure ssl = true

  Scenario: Verificar que un endpoint público responde 200
    Given url 'https://httpbin.org/get'
    When method get
    Then status 200


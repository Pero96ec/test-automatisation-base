
@REQ_HU-1234 @HU1234 @marvel_characters_management @marvel_characters_api @Agente2 @E2 @iniciativa_marvel @automation_with_copilotFeature: Test de API súper simple

Feature: HU-1234 Gestión de personajes de Marvel (microservicio para administrar personajes de Marvel)
  Background:
    * configure ssl = true
    * url 'http://bp-se-test-cabcd9b246a5.herokuapp.com'
    * path '/testuser/api/characters'
    * def generarHeaders =
      """
      function() {
        return {
          "Content-Type": "application/json"
        };
      }
      """
    * def headers = generarHeaders()
    * headers headers

  @id:1 @obtenerTodosPersonajes @respuestaExitosa200
  Scenario: T-API-HU-1234-CA01-Obtener todos los personajes exitosamente 200 - karate
    When method GET
    Then status 200
    # And match response != null
    # And match response.length >= 0



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


  @id:2 @obtenerPersonajePorId @respuestaExitosa200
  Scenario: T-API-HU-1234-CA02-Obtener personaje por ID exitosamente 200 - karate
    * path '/33'
    When method GET
    Then status 200
    # And match response.id != null
    # And match response.name != null

  @id:3 @obtenerPersonajePorId @personajeNoExiste404
  Scenario: T-API-HU-1234-CA03-Obtener personaje por ID no existente 404 - karate
    * path '/999999'
    When method GET
    Then status 404
    # And match response.message contains 'not found'
    # And match response.status == 404

  @id:4 @crearPersonaje @creacionExitosa201
  Scenario: T-API-HU-1234-CA04-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:data/marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    # And match response.id != null
    # And match response.name == jsonData.name

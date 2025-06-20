
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

## Escenarios GET

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
    * def jsonData = read('classpath:marvel_characters_api/request_create_character.json')
    And request jsonData
    When method POST
    Then status 201
    # And match response.id != null
    # And match response.name == jsonData.name

  ## Escenarios POST

  @id:5 @crearPersonaje @nombreDuplicado409
  Scenario: T-API-HU-1234-CA05-Crear personaje con nombre duplicado 409 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_duplicate_character.json')
    And request jsonData
    When method POST
    Then status 409
    # And match response.message contains 'already exists'
    # And match response.status == 409

  @id:6 @crearPersonaje @camposFaltantes400
  Scenario: T-API-HU-1234-CA06-Crear personaje con campos requeridos faltantes 400 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_invalid_character.json')
    And request jsonData
    When method POST
    Then status 400
    # And match response.message contains 'validation error'
    # And match response.status == 400

  ## Escenarios PUT

  @id:7 @actualizarPersonaje @actualizacionExitosa200
  Scenario: T-API-HU-1234-CA07-Actualizar personaje exitosamente 200 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_update_character.json')
    * path '/1'
    And request jsonData
    When method PUT
    Then status 200
    # And match response.id != null
    # And match response.description == jsonData.description

  @id:8 @actualizarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-1234-CA08-Actualizar personaje no existente 404 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_update_character.json')
    * path '/999999'
    And request jsonData
    When method PUT
    Then status 404
    # And match response.message contains 'not found'
    # And match response.status == 404

  ## Escenarios DELETED

  @id:9 @eliminarPersonaje @eliminacionExitosa200
  Scenario: T-API-HU-1234-CA09-Eliminar personaje exitosamente 200 - karate
    * path '/1'
    When method DELETE
    Then status 200
    # And match response.message contains 'deleted'
    # And match response.status == 200

  @id:10 @eliminarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-1234-CA10-Eliminar personaje no existente 404 - karate
    * path '/999999'
    When method DELETE
    Then status 404
    # And match response.message contains 'not found'
    # And match response.status == 404
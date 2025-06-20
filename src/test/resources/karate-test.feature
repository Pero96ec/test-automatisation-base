
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
    And match response != null


  @id:2 @obtenerPersonajePorId @respuestaExitosa200
  Scenario: T-API-HU-1234-CA02-Obtener personaje por ID exitosamente 200 - karate
        # Primero crear un personaje para obtener un ID válido
    * def createData = read('classpath:marvel_characters_api/request_create_character.json')
    * def randomName = 'GetTest_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * set createData.name = randomName
    And request createData
    When method POST
    Then status 201
    * def createdId = response.id
    
    # Ahora obtengo el personaje creado asi evito que borren los id en el servicio y se caiga los test
    * path '/' + createdId
    When method GET
    Then status 200
    And match response.id != null
    And match response.name != null

  @id:3 @obtenerPersonajePorId @personajeNoExiste404
  Scenario: T-API-HU-1234-CA03-Obtener personaje por ID no existente 404 - karate
    * path '/1999999'
    When method GET
    Then status 404
    And match response.error contains 'not found'

  @id:4 @crearPersonaje @creacionExitosa201
  Scenario: T-API-HU-1234-CA04-Crear personaje exitosamente 201 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_create_character.json')
    * def randomName = 'Hero_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * set jsonData.name = randomName
    And request jsonData
    When method POST
    Then status 201
    And match response.id != null
    And match response.name == jsonData.name
    And match response.name == randomName

  ## Escenarios POST

  @id:5 @crearPersonaje @nombreDuplicado409
  Scenario: T-API-HU-1234-CA05-Crear personaje con nombre duplicado 409 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_duplicate_character.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.error contains 'already exists'

  @id:6 @crearPersonaje @camposFaltantes400
  Scenario: T-API-HU-1234-CA06-Crear personaje con campos requeridos faltantes 400 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_invalid_character.json')
    And request jsonData
    When method POST
    Then status 400
    And match response.name contains 'required'
    And match response.description contains 'required'
    And match response.powers contains 'required'
    And match response.alterego contains 'required'

  ## Escenarios PUT

  @id:7 @actualizarPersonaje @actualizacionExitosa200
  Scenario: T-API-HU-1234-CA07-Actualizar personaje exitosamente 200 - karate
    # Primero crear un personaje para obtener un ID válido
    * def createData = read('classpath:marvel_characters_api/request_create_character.json')
    * def randomName = 'UpdateTest_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * set createData.name = randomName
    And request createData
    When method POST
    Then status 201
    * def createdId = response.id
    
    # Ahora actualizar el personaje creado
    * def jsonData = read('classpath:marvel_characters_api/request_update_character.json')
    * set jsonData.name = randomName + '_Updated'
    * path '/' + createdId
    And request jsonData
    When method PUT
    Then status 200
    And match response.id != null
    And match response.description == jsonData.description

  @id:8 @actualizarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-1234-CA08-Actualizar personaje no existente 404 - karate
    * def jsonData = read('classpath:marvel_characters_api/request_update_character.json')
    * path '/199999'
    And request jsonData
    When method PUT
    Then status 404
    And match response.error contains 'not found'

  ## Escenarios DELETED

  @id:9 @eliminarPersonaje @eliminacionExitosa200
  Scenario: T-API-HU-1234-CA09-Eliminar personaje exitosamente 200 - karate
    # Primero crear un personaje para obtener un ID válido
    * def createData = read('classpath:marvel_characters_api/request_create_character.json')
    * def randomName = 'DeleteTest_' + java.util.UUID.randomUUID().toString().substring(0, 8)
    * set createData.name = randomName
    And request createData
    When method POST
    Then status 201
    * def createdId = response.id
    
    # Ahora eliminar el personaje creado
    * path '/' + createdId
    When method DELETE
    Then status 204

  @id:10 @eliminarPersonaje @personajeNoExiste404
  Scenario: T-API-HU-1234-CA10-Eliminar personaje no existente 404 - karate
    * path '/999999'
    When method DELETE
    Then status 404
    And match response.error contains 'not found'
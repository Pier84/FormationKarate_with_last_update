@ztrain
Feature: login user

  Background:

    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/loginUser.json')


  Scenario: Login User


    #Given def createUser = call read('classpath:configurations/demo/repo/registerUser.feature')


    Given url 'https://api-ztrain.onrender.com'
    And path '/auth/login/'
    And header Content-Type = 'application/json'
    And request req
    When method POST
    Then status 201
    #And print response.token






@ztrain
Feature: Register new user

  Background:

    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('classpath:ztrain/features/data/registerUser.json')
    # J'indique l'url qui va etre utilisé pour tous les scénarios de cette feature en faisant référence à la variable one.url spécifié dans le karate-config.js
    * url BaseUrl
    * def RandomEmail = Java.type('Uuid.
  ')
    # Je stock dans la variable PUnique une chaine de caracteres al?atoire
    * def Email = RandomEmail.generateRandomEmail()
    * print Email
    * def temp = req.email
    * set req.email = Email
    * print req.email






  Scenario: registerUser


    # Remarquez que ce n'est plus nécessaire d'indiquer l'url mais juste le path
    Given path '/user/register'
    And header Content-Type = 'application/json'
    And header accept = 'application/json'
    And request req
    When method POST
    Then status 201









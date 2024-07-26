@ztrain
Feature: Add a new comment

  Background:

     # J'indique l'url qui va etre utilisé pour tous les scénarios de cette feature en faisant référence à la variable one.url spécifié dans le karate-config.js
    * url BaseUrl
    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/addComment.json')





  Scenario: Add a comment to a product
    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token

    Given path '/product/comments/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request  req
    When method POST
    Then status 201





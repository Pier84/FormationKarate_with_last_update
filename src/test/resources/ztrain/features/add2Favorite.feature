@ztrain
Feature: Add a product to favorites

  Background:

     # J'indique l'url qui va etre utilisé pour tous les scénarios de cette feature en faisant référence à la variable one.url spécifié dans le karate-config.js
    * url BaseUrl
    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/add2Favorite.json')



  Scenario: Add to favorites
    Given def ProductId = call read('this:createNewProduct.feature')
    And print ProductId.response._id


    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token
    And print TokenGen.response.user._id

    Given path '/favorites/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And set req.user = TokenGen.response.user._id
    And set req.product = ProductId.response._id
    And request  req
    When method POST
    Then status 201


    # Retirer un produit des favoris



    Given path '/favorites/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request read ('this:data/add2Favorite.json')
    When method POST
    Then status 201
    #And match response.message == "Vous avez supprim? ce produit de vos favoris"


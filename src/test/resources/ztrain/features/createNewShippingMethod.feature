@ztrain
Feature: Create new shipping method

  Background:

     # J'indique l'url qui va etre utilisé pour tous les scénarios de cette feature en faisant référence à la variable one.url spécifié dans le karate-config.js
    * url BaseUrl
    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/createNewShippingMethod.json')
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
    * def PUnique = NomProduitUnique.instance.unique()
    * print PUnique
    * def temp = req.designation
    * print temp
    * set req.designation = temp + PUnique
    * print req.designation




  Scenario: Create a new shipping method
    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token

    Given path '/shipping-method/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request  req
    When method POST
    Then status 201


    # check if shipping method already exists



      Given path '/shipping-method/create'
      And header Content-Type = 'application/json'
      And header Authorization = "Bearer " + TokenGen.response.token
      And request req
      When method POST
      Then status 403
      And response.error = "Cette methode de livraison existe déja"

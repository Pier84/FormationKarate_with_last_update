@ztrain
Feature: Create new category

  Background:

    # J'indique l'url qui va être utilisé pour tous les scénarios de cette feature en faisant référence à la variable one.url spécifié dans le karate-config.js
    * url BaseUrl
   # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/createNewCat.json')
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
   # Je stock dans la variable PUnique une chaine de caracteres aléatoire
    * def PUnique = NomProduitUnique.instance.unique()
    * def temp = req.name
    * print temp
    * set req.name = temp + PUnique
    * print req.name




  Scenario: Create a new category
    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token

    Given path '/category/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request req
    When method POST
    Then status 201


   # Controle d'unicité



    Given path '/category/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request req
    When method POST
    Then status 201


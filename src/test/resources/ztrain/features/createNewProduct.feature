
@ztrain
Feature: create new product

  Background:

    # Je stock dans la variable req le fichier à passer dans le body de ma requete Post
    * def req = read ('this:data/createNewProduct.json')
    # Je stock dans la variable NomProduitUnique la classe Java pour la création d'une chaine de caracteres aléatoire
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
    # Je stock dans la variable PUnique une chaine de caracteres aléatoire
    * def PUnique = NomProduitUnique.instance.unique()
    * print PUnique
    * def temp = req.name
    * set req.name = temp + PUnique
    * print req.name






  Scenario: create a new product


    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token


    Given url 'https://api-ztrain.onrender.com'
    And path '/product/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request req
    When method POST
    Then status 201
    And if (responseStatus == 201) karate.log('Request succeeded')


    # Début des tests
    And match response.price == 10
    And match $.price == 10
    # Je vais vérifier que dans le tableau "height", on ait bien l'élément "M"
    And match $.attributs.height contains 'M'
    # Je vérifie que le champs isActive est bien à false
    And match $.isActive == false













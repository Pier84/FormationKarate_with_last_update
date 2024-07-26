@ztrain
Feature: Create new category

  Background:

    # J'indique l'url qui va �tre utilis� pour tous les sc�narios de cette feature en faisant r�f�rence � la variable one.url sp�cifi� dans le karate-config.js
    * url BaseUrl
   # Je stock dans la variable req le fichier � passer dans le body de ma requete Post
    * def req = read ('this:data/createNewCat.json')
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
   # Je stock dans la variable PUnique une chaine de caracteres al�atoire
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


   # Controle d'unicit�



    Given path '/category/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request req
    When method POST
    Then status 201


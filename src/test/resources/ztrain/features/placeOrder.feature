@ztrain
Feature: Place an order

  Background:

     # J'indique l'url qui va etre utilis� pour tous les sc�narios de cette feature en faisant r�f�rence � la variable one.url sp�cifi� dans le karate-config.js
    * url BaseUrl
    # Je stock dans la variable req le fichier � passer dans le body de ma requete Post
    * def req = read ('this:data/registerUser.Json')
    # Je stock dans la variable reqNewP le fichier � passer dans le body de ma requete Post pour le scenario de cration d'un nouveau produit
    * def reqNewP = read ('this:data/createNewProduct.json')
    # Je stock dans la variable reqAdd2cart le fichier � passer dans le body de ma requete Post pour le scenario d'ajout au panier
    * def reqAdd2cart = read ('this:data/add2cart.json')
     # Je stock dans la variable reqAdd2Favoris le fichier � passer dans le body de ma requete Post pour le scenario d'ajout aux favoris
    * def reqAdd2Favoris = read ('this:data/add2Favorite.json')
    # Je stock dans la variable reqPlaceOrder le fichier � passer dans le body de ma requete Post pour le scenario de cr�ation de commande
    * def reqPlaceOrder = read ('this:data/submitOrder.json')
    # Je stock dans la variable NomProduitUnique la classe Java pour la cr�ation d'une chaine de caracteres al�atoire
    * def NomProduitUnique = Java.type('Uuid.prdUnique')
    # Je stock dans la variable PUnique une chaine de caracteres al�atoire
    * def PUnique = NomProduitUnique.instance.unique()
    * def temp = reqNewP.name
    * set reqNewP.name = temp + PUnique
    * print reqNewP.name



  Scenario: registerUser


    Given path '/user/register'
    And header Content-Type = 'application/json'
    And header accept = 'application/json'
    And request req
    When method POST
    Then status 201

  Scenario: Login User

    Given path '/auth/login/'
    And header Content-Type = 'application/json'
    And header accept = 'application/json'
    And request req
    When method POST
    Then status 201



  Scenario: create a new product and add to cart

    Given def TokenGen = call read('this:loginUser.feature')
    And print TokenGen.response.token
    And print TokenGen.response.user._id
    And print TokenGen.response



    Given path '/product/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request reqNewP
    When method POST
    Then status 201
    And print response
    And def ProdCreateResp = $response
    And print response.id
    And def prodId = response.id

    # D�but des tests
    And match response.price == 10
    # Je vais v�rifier que dans le tableau "height", on ait bien les �l�ments "L" & "M"
    And match $.attributs.height contains ["M","L"] == true
    # Je v�rifie que le champs isActive est bien � false
    And match $.isActive == false
    # Je v�rifie que le nom du produit en base de donn�es est bien celui renseign� en entr�e
    And match $.name == reqNewP.name

 # ajout du produit au panier

    Given path '/cart/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And set reqAdd2cart.product = prodId
    And set reqAdd2cart.user_id = TokenGen.response.user._id
    And request reqAdd2cart
    When method POST
    Then status 201

# Mise � jour de la quantit� dans le panier

    Given path '/cart/update'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And set reqAdd2cart.quantity = 5
    And request reqAdd2cart
    When method PUT
    Then status 200

# Passer sa commande

    Given path '/command/create'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And set reqPlaceOrder.user_id = TokenGen.response.user._id
    And set reqPlaceOrder.products[0].product = ProdCreateResp
    And set reqPlaceOrder.products[0].quantity = reqAdd2cart.quantity
    And request reqPlaceOrder
    When method POST
    Then status 201
    And match response.message contains "Bravo!!! votre commande"

    # Ajout du produit aux favoris

    Given path '/favorites/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And set reqAdd2Favoris.user = TokenGen.response.user._id
    And set reqAdd2Favoris.product = prodId

    And request  reqAdd2Favoris
    When method POST
    Then status 201


    # Retirer un produit des favoris



    Given path '/favorites/add'
    And header Content-Type = 'application/json'
    And header Authorization = "Bearer " + TokenGen.response.token
    And request reqAdd2Favoris
    When method POST
    Then status 201
    #And match response.message == "Vous avez supprim� ce produit de vos favoris"







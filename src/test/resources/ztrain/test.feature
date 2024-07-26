Feature: My first feature with Karate

 Background:

   * configure ssl = true
   * url 'https://zenity.fr'


 Scenario: test de connexion au site de Zenity

   Given path '/identite'
   When method GET
   Then status 200
   #And match responseStatus == 200
   #And match responseTime == 500

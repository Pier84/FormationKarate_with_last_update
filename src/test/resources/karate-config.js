function fn() {
  var env = karate.env; // get system property 'karate.env'

  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'FormationKarate_Env'; // définir un environment par défaut
  }
  var config = {
    env: env,
	myVarName: 'someValue'

  }
  if (env == 'FormationKarate_Env') {
  config.BaseUrl = 'https://api-ztrain.onrender.com';
  config.security = {
        allow: ['Uuid.*']
      };

    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
  config.BaseUrl = 'https://api-ztrain.onrenderv2.com';
    // customize
  }
  return config;
}
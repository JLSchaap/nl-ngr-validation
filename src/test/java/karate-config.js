function fn() {    
  karate.configure('retry',{ count:20, interval:5000});
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  karate.configure('ssl', true);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	myVarName: 'someValue'
  }

  return config;
}
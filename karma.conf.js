module.exports = function(config){
  config.set({

    basePath : './',

    files : [
      'public/javascripts/vendor.js',
      'app/config/angular/validation/match.coffee',
      'public/javascripts/app.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'test/**/*.coffee'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers : ['Chrome'],

    preprocessors: { '**/*.coffee': 'coffee' },

    plugins : [
            'karma-coffee-preprocessor',
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-jasmine',
            'karma-junit-reporter'
            ],

    logLevel: config.LOG_DEBUG,

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};

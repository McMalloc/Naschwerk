/*
 * This file in the main entry point for defining grunt tasks and using grunt plugins.
 * Click here to learn more. http://go.microsoft.com/fwlink/?LinkID=513275&clcid=0x409
 */

function makehash() {
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  for (var i = 0; i < 5; i++)
    text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

module.exports = function (grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    clean: {
      libs: ['public/libs/*']
    },
    uglify: {
      options: {
        mangle: false
      },
      bundle: {
        files: {
          'public/libs/bundle.js': [
            'node_modules/jquery/dist/jquery.slim.js',
            'node_modules/bootstrap/dist/js/bootstrap.js']
        }
      }
    },
    cssmin: {
      options: {
        mergeIntoShorthands: false,
        roundingPrecision: -1
      },
      target: {
        files: {
          'public/libs/bundle.css': [
            'node_modules/bootstrap/dist/css/bootstrap.css',
            'node_modules/bootstrap/dist/css/bootstrap-grid.css',
            'node_modules/bootstrap/dist/css/bootstrap-reboot.css'
          ]
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.registerTask('bundle', ['clean:libs', 'uglify', 'cssmin']);

};

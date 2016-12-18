(function (){
  'use strict';

  var express   = require("express")
    , request   = require("request")
    , helpers   = require("../../helpers")
    , app = express()

   
  // List items in cart for current logged in user.
  app.get("/ip", function (req,res,next) {
      var address,
          ifaces = require('os').networkInterfaces();
      for (var dev in ifaces) {
          ifaces[dev].filter((details) => details.family === 'IPv4' && details.internal === false ? address = details.address: undefined);
      }
      helpers.respondStatusBody(res,200,address);
    });
  module.exports = app;
  }());


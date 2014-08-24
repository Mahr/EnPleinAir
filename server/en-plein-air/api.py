__author__ = 'seanbrady'

import wsgiref.handlers
import logging

import dataModel
import testData
import datetime

import traceback
import sys
import json
from datetime import datetime, date, time

from dataModel import Landscape
from dataModel import Theme
from dataModel import Themescape
from dataModel import Plantscape


import webapp2
from google.appengine.ext import ndb
from google.appengine.api import memcache


class GetLandscapes(webapp2.RequestHandler):

    def get(self):


        theme_id = self.request.get("theme_id")
        theme_key = ndb.Key(Theme, theme_id)

        themescapes = Themescape.query(Themescape.theme == theme_key).fetch()

        outArray = []
        for themescape in themescapes:
            outArray.append(themescape.landscape.get().toJson())

        self.response.headers['Content-Type'] = "application/json"
        self.response.write(json.dumps(outArray))



class GetThemes(webapp2.RequestHandler):

    def get(self):
        qry = Theme.query()

        resArray = []
        for theme in qry.fetch(limit=30, offset=0):
            resArray.append(theme.toJson())

        self.response.headers['Content-Type'] = "application/json"
        self.response.write(json.dumps(resArray))



class GetPlants(webapp2.RequestHandler):

    def get(self):


        landscape_id = self.request.get("landscape_id")
        landscape_key = ndb.Key(Landscape, landscape_id)

        plantscapes = Plantscape.query(Plantscape.landscape == landscape_key).fetch()

        outArray = []
        for plantscape in plantscapes:
            outArray.append(plantscape.plant.get().toJson())

        self.response.headers['Content-Type'] = "application/json"
        self.response.write(json.dumps(outArray))
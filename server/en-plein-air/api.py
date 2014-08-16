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


import webapp2
from google.appengine.ext import ndb
from google.appengine.api import memcache


class GetLandscapes(webapp2.RequestHandler):

    def get(self):
        theme_id = self.request["theme_id"]

        qry = Landscape.query()

        resArray = []
        for landscape in qry.fetch(10, offset=0):
            resArray.append(landscape.toJson())

        self.response.headers['Content-Type'] = "application/json"
        self.response.write(json.dumps(resArray))



class GetThemes(webapp2.RequestHandler):

    def get(self):
        qry = Theme.query()

        resArray = []
        for theme in qry.fetch(10, offset=0):
            resArray.append(theme.toJson())

        self.response.headers['Content-Type'] = "application/json"
        self.response.write(json.dumps(resArray))
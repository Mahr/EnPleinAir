__author__ = 'seanbrady'

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


import webapp2
from google.appengine.ext import ndb
from google.appengine.api import memcache


class GetLandscapes(webapp2.RequestHandler):

    def get(self):
        qry = Landscape.query()

        resArray = [];
        for landscape in qry.fetch(10, offset=0): # Skip the first 20
            resArray.append(landscape.toJson())

        self.response.write(json.dumps(resArray))
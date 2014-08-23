__author__ = 'seanbrady'

import wsgiref.handlers
import logging

import dataModel
import testData
import datetime

import traceback
import sys


import webapp2
from google.appengine.ext import ndb
from google.appengine.api import memcache
from google.appengine.api import urlfetch
from django.utils import simplejson

class AddTestData(webapp2.RequestHandler):

    def get(self):
        loadLandscape()
        loadPlant()
        loadTheme()
        loadPlantscape()
        loadThemescape()


def loadLandscape():
    testData.deleteTable("Landscape")
    worksheet_key = "od6"

    url = "https://spreadsheets.google.com/feeds/list/1gvNARc_5YSJoSGI_rScivpLh0gcsHDaY-2BqEzAp47Y/"+worksheet_key+"/public/values?alt=json"

    result = urlfetch.fetch(url)
    if result.status_code == 200:
        feed_obj = simplejson.loads(result.content)
    if "feed" in feed_obj:
        entries = feed_obj["feed"]["entry"]

        # Make an Application entity for each entry in feed
        for entry in entries:
            id = entry['gsx$id']['$t']
            name = entry['gsx$name']['$t']
            description = entry['gsx$description']['$t']
            lscape_url = entry['gsx$url']['$t']
            designer = entry['gsx$designer']['$t']
            designer_website = entry['gsx$designerwebsite']['$t']

            testData.addLandscape(id, name, description, lscape_url, designer, designer_website)


def loadPlant():
    testData.deleteTable("Plant")
    worksheet_key = "oyab5tm"

    url = "https://spreadsheets.google.com/feeds/list/1gvNARc_5YSJoSGI_rScivpLh0gcsHDaY-2BqEzAp47Y/"+worksheet_key+"/public/values?alt=json"

    result = urlfetch.fetch(url)
    if result.status_code == 200:
        feed_obj = simplejson.loads(result.content)
    if "feed" in feed_obj:
        entries = feed_obj["feed"]["entry"]

        # Make an Application entity for each entry in feed
        for entry in entries:
            id = entry['gsx$id']['$t']
            name = entry['gsx$name']['$t']
            latin_name = entry['gsx$latinname']['$t']
            description = entry['gsx$description']['$t']
            lscape_url = entry['gsx$url']['$t']
            link = entry['gsx$link']['$t']

            testData.addPlant(id, name, latin_name, description, lscape_url, link)


def loadTheme():
    testData.deleteTable("Theme")
    worksheet_key = "o8u2oo0"

    url = "https://spreadsheets.google.com/feeds/list/1gvNARc_5YSJoSGI_rScivpLh0gcsHDaY-2BqEzAp47Y/"+worksheet_key+"/public/values?alt=json"

    result = urlfetch.fetch(url)
    if result.status_code == 200:
        feed_obj = simplejson.loads(result.content)
    if "feed" in feed_obj:
        entries = feed_obj["feed"]["entry"]

        # Make an Application entity for each entry in feed
        for entry in entries:
            id = entry['gsx$id']['$t']
            name = entry['gsx$name']['$t']
            lscape_url = entry['gsx$url']['$t']

            testData.addTheme(id, name, lscape_url)


def loadPlantscape():
    testData.deleteTable("Plantscape")
    worksheet_key = "oxegisu"

    url = "https://spreadsheets.google.com/feeds/list/1gvNARc_5YSJoSGI_rScivpLh0gcsHDaY-2BqEzAp47Y/"+worksheet_key+"/public/values?alt=json"

    result = urlfetch.fetch(url)
    if result.status_code == 200:
        feed_obj = simplejson.loads(result.content)
    if "feed" in feed_obj:
        entries = feed_obj["feed"]["entry"]

        # Make an Application entity for each entry in feed
        for entry in entries:
            landscape_id = entry['gsx$landscapeid']['$t']
            plant_id = entry['gsx$plantid']['$t']

            testData.addPlantscape(landscape_id, plant_id)


def loadThemescape():
    testData.deleteTable("Themescape")
    worksheet_key = "of5pfd4"

    url = "https://spreadsheets.google.com/feeds/list/1gvNARc_5YSJoSGI_rScivpLh0gcsHDaY-2BqEzAp47Y/"+worksheet_key+"/public/values?alt=json"

    result = urlfetch.fetch(url)
    if result.status_code == 200:
        feed_obj = simplejson.loads(result.content)
    if "feed" in feed_obj:
        entries = feed_obj["feed"]["entry"]

        # Make an Application entity for each entry in feed
        for entry in entries:
            landscape_id = entry['gsx$landscapeid']['$t']
            theme_id = entry['gsx$themeid']['$t']

            testData.addThemescape(landscape_id, theme_id)


def deleteTable(name):
    #Delete everything first
    while True:
        q = ndb.gql("SELECT __key__ FROM " + name)
        if q.count() is 0:
            break
        ndb.delete_multi(q.fetch(200))


def addLandscape(id, name, description, image, designer, designer_website):
    landscape = dataModel.Landscape(id = id, image_url = image, name = name, description = description, designer = designer, designer_website = designer_website)
    return landscape.put()

def addPlant(id, name, latin_name, description, image_url, link):
    #Should check to see if latin name already taken
    plant = dataModel.Plant(id = id, name = name, latin_name = latin_name, description = description, image_url = image_url, link = link)
    return plant.put()

def addTheme(id, name, image_url):
    theme = dataModel.Theme(id = id, name = name, image_url = image_url)
    return theme.put()


def addPlantscape(landscape_id, plant_id):
    pscape = dataModel.Plantscape(landscape = ndb.Key(dataModel.Landscape, landscape_id), plant = ndb.Key(dataModel.Plant, plant_id))
    pscape.put()

def addThemescape(landscape_id, theme_id):
    tscape = dataModel.Themescape(landscape = ndb.Key(dataModel.Landscape, landscape_id), theme = ndb.Key(dataModel.Theme, theme_id))
    tscape.put()






            # logging.info("In " + self.__class__.__name__)
        # l1 = testData.addLandscape("Landscape 1", "Description 1", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693202/df61b9ae3c3ed2f00cd78bba305e6d20_ecv7qj.jpg")
        # l2 = testData.addLandscape("Landscape 2", "Description 2", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693199/defaultImage_ftsuia.png")
        #
        #
        # p1 = testData.addPlant("Plant 1", "plantus 1us", "plant desc 1", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693298/sample.jpg")
        # p2 = testData.addPlant("Plant 2", "plantus 2us", "plant desc 2", "http://res.cloudinary.com/en-plein-air/image/upload/c_crop,w_295,x_0/v1404693298/sample.jpg")
        #
        #
        # addPlantscape(l1, p1)
        # addPlantscape(l1, p2)
        #
        # addPlantscape(l2, p2)
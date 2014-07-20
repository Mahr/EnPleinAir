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


class AddTestData(webapp2.RequestHandler):

    def get(self):
        logging.info("In " + self.__class__.__name__)
        l1 = testData.addLandscape("Landscape 1", "Description 1", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693202/df61b9ae3c3ed2f00cd78bba305e6d20_ecv7qj.jpg")
        l2 = testData.addLandscape("Landscape 2", "Description 2", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693199/defaultImage_ftsuia.png")


        p1 = testData.addPlant("Plant 1", "plantus 1us", "plant desc 1", "http://res.cloudinary.com/en-plein-air/image/upload/v1404693298/sample.jpg")
        p2 = testData.addPlant("Plant 2", "plantus 2us", "plant desc 2", "http://res.cloudinary.com/en-plein-air/image/upload/c_crop,w_295,x_0/v1404693298/sample.jpg")


        addPlantscape(l1, p1)
        addPlantscape(l1, p2)

        addPlantscape(l2, p2)



def addLandscape(name, description, image):
    landscape = dataModel.Landscape(image_url = image, name = name, description = description)
    return landscape.put().get()

def addPlant(name, latin_name, description, image_url):
    #Should check to see if latin name already taken
    plant = dataModel.Plant(name = name, latin_name = latin_name, description = description, image_url = image_url)
    return plant.put().get()

def addPlantscape(landscape, plant):
    pscape = dataModel.Plantscape(landscape = landscape.key, plant = plant.key)
    pscape.put()
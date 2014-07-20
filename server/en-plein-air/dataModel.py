from google.appengine.ext import ndb
from google.appengine.ext import blobstore
import logging

class Landscape(ndb.Model):
    image_url = ndb.StringProperty(required=False)
    name = ndb.StringProperty(required=False)
    description = ndb.StringProperty(required=False)
    date_added = ndb.DateTimeProperty(auto_now_add=True)

    def toJson(self):
        return {"id":self.key.urlsafe(), "image_url":self.image_url, "name":self.name, "description":self.description, "date_added":str(self.date_added)}


class Plant(ndb.Model):
    image_url = ndb.StringProperty(required=False)
    name = ndb.StringProperty(required=False)
    latin_name = ndb.StringProperty(required=False)
    description = ndb.StringProperty(required=False)


class Plantscape(ndb.Model):
    landscape = ndb.KeyProperty(kind=Landscape)
    plant = ndb.KeyProperty(kind=Plant)
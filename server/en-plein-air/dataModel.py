from google.appengine.ext import ndb
from google.appengine.ext import blobstore
import logging

class Landscape(ndb.Model):
    image_url = ndb.StringProperty(required=False)
    name = ndb.StringProperty(required=False)
    description = ndb.StringProperty(required=False)
    date_added = ndb.DateTimeProperty(auto_now_add=True)

    def toJson(self):
        return {"id":self.key.id(), "image_url":self.image_url, "name":self.name, "description":self.description, "date_added":str(self.date_added)}


class Plant(ndb.Model):
    image_url = ndb.StringProperty(required=False)
    name = ndb.StringProperty(required=False)
    latin_name = ndb.StringProperty(required=False)
    description = ndb.StringProperty(required=False)

    def toJson(self):
        return {"id":self.key.id(), "image_url":self.image_url, "name":self.name, "latin_name":self.latin_name, "description":self.description}


class Theme(ndb.Model):
    name = ndb.StringProperty(required=True)
    image_url = ndb.StringProperty(required=True)

    def toJson(self):
        return {"id":self.key.id(), "image_url":self.image_url, "name":self.name}


class Plantscape(ndb.Model):
    landscape = ndb.KeyProperty(kind=Landscape)
    plant = ndb.KeyProperty(kind=Plant)


class Themescape(ndb.Model):
    landscape = ndb.KeyProperty(kind=Landscape)
    theme = ndb.KeyProperty(kind=Theme)
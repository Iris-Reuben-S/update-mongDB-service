import re
import sys
import json
from os import listdir
from os.path import isfile, join
import pymongo

path = "/home/test-pi/test-output/"

def main():
	json_list = [f for f in listdir(path) if isfile(join(path, f))]
	pi_client = pymongo.MongoClient("mongodb://localhost:2717")
	pi_db = pi_client["pi_db"]
	pi_coll = pi_db["pi_data"]
	
	for i in json_list:
		with open(path + "" + i) as f:
			try:
				json_data = json.load(f)
				pi_coll.insert_one(json_data)
			except pymongo.errors.DuplicateKeyError as err:
				print(err, file=sys.stderr)
				 
	pi_client.close()
main()

import requests
import os
from datetime import datetime

url = os.environ['IOT_SERVER']
self_id = os.environ['SELF_ID']
params = {"time": datetime.now().strftime("%Y-%m-%d %H:%M:%S"), "self_id": self_id}
r = requests.get(url, params=params)

print(r.text)

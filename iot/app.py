import requests
import os
from datetime import datetime

url = os.environ['IOT_SERVER']
params = {"time": datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
r = requests.get(url, params=params)

print(r.text)

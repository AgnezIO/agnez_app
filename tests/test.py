import random
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import mpld3
import requests
import time
import json


# initialize
url = "./images/main_img.gif"
r = requests.post("http://localhost:3000/api/v1/values",
                  json={'name': '', 'type': 'html', 'value': [], 'pos': 0,
                        'description': ''})
id0 = json.loads(r.text)["_id"]
r = requests.post("http://localhost:3000/api/v1/values",
                  json={'name': '', 'type': 'img', 'value': [], 'pos': 1,
                        'description': ''})
id1 = json.loads(r.text)["_id"]
fig = plt.figure(figsize=(8, 5))
numbers = []
for i in range(100):
    time.sleep(2)
    plt.clf()
    numbers.append(random.random())
    plt.plot(numbers)
    if len(numbers) > 20:
        del numbers[0]
    html = mpld3.fig_to_html(fig)
    r = requests.patch("http://localhost:3000/api/v1/values/" + str(id0),
                       json={'name': 'test1', 'type': 'html', 'value': html,
                             'pos': 0, 'description': 'simple test'})
    r = requests.patch("http://localhost:3000/api/v1/values/" + str(id1),
                       json={'name': 'test2', 'type': 'img', 'value': url,
                             'pos': 1, 'description': 'simple image'})
    print r

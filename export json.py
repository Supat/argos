#%%

import json
import os
from os import listdir
from os.path import isfile, join
from os import walk
from urllib.parse import urlparse
from os.path import splitext
#%%

data = {}
data['category'] = []
folder = '/Users/zuicoolnoguy/Karate_testdata/'
categories = [name for name in os.listdir(folder) if os.path.isdir(os.path.join(folder, name))]
def get_ext(url):
    parsed = urlparse(url)
    root, ext = splitext(parsed.path)
    return ext

#%% 
# Categories
for i in range(len(categories)):
    data['category'].append({
        'name': categories[i]
    })

#%%
# Videos
data['video'] = []
for i in range(len(categories)):
    _, _, filenames = next(walk(folder+categories[i]))
 #   print(filenames,categories[i])
    for j in range(len(filenames)):
        data['video'].append({
            'url': filenames[j],
            'explanation': None,
            'difficulty': None,
            'belongTo': categories[i],
            'type': get_ext(filenames[j])[1:]
        })

#%%
# Results
json.dumps(data)

#%%

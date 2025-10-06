#!/bin/bash
shopt -s expand_aliases
source ~/.profile

#delete old
rm -r website

#TODO: Get name of this file and uncomment
# if [ ! -f "build/web/simplesite.js" ]; then
#     # Clean because it doesn't remake flutter.js & canvaskit otherwise
#     flutter clean
# fi
# flutter clean

# We're using "website" because "web" is needed for the build, and contains our index.html
# You don't need the shit in the current web folder once it's built
flutter build web --release --base-href=/website/


# mkdir website
mv build/web ./website


notify

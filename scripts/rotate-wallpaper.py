import random
import os
import time
from subprocess import call
from pydaemon import Daemon

# I thew this together when I was angry that this file was suddenly empty
class rotateWallpaper(Daemon):
    def run(self):
        home = os.environ['HOME']
        dir = os.path.join(home, "Pictures", "backgrounds")
        frequency = 60 # Time in minutes to change background

        frequency *= 60

        while True:
            # Intentionally get all the files every time
            files = [ f for f in os.listdir(dir) if os.path.isfile(os.path.join(dir, f)) ]
            newbg = random.sample(files,1)[0]

            call(["hsetroot", "-fill", os.path.join(dir, newbg)])

            time.sleep(frequency*60)

if __name__ == '__main__':
    i = rotateWallpaper('/tmp/rotate-wallpaper-'+os.environ['USER']+'.pid')
    i.run()

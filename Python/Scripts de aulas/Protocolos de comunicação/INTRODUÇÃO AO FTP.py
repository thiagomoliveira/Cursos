# File transfer protocol
# Indicado para arquivos, imagens, etc

from ftplib import *

ftp = FTP('ftp.ibiblio.org')

print(ftp.getwelcome())

ftp.quit()

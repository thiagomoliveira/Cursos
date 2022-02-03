from ftplib import *

ftp = FTP('ftp.ibiblio.org')
print(ftp.getwelcome())

usuario = input("Digite o usuário: ")

senha = input("DIgite a senha: ")

ftp.login(usuario, senha)

print("Diretório atual de trabalho: ", ftp.pwd())

ftp.cwd('pub')

print("Diretório corrente: ", ftp.pwd())

print(ftp.retrlines("LIST"))

ftp.quit()

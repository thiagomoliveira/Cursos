from socket import *

servidor = "127.0.0.1"
porta = 43210

obj_socket = socket(AF_INET, SOCK_STREAM)
#(AF_INET, SOCK_STREAM)  - (Tipo de identificação com servidor (IP ou hostname) // Feito pra trabalhar com prot.TCP)

obj_socket.bind((servidor, porta))
obj_socket.listen(2)

print("Aguardando cliente...")

while True:
    con, cliente = obj_socket.accept() ## Esse método espera um cliente se conectar (retorna Tupla - conexão e identificação do cliente)
    print("conectado com ", cliente)
    while True:
        msg_recebida = str(con.recv(1024)) ## Quantidade de bites que eu espero no pacote (tamanho em bites)
        print("Recebemos ", msg_recebida)
        msg_enviada = b'Olá cliente'
        con.send(msg_enviada)
        break
    con.close()







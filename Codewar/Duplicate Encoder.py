# The goal of this exercise is to convert a string to a new
# string where each character in the new string is "(" if that
# character appears only once in the original string, or ")" if
# that character appears more than once in the original string.
# Ignore capitalization when determining if a character is a duplicate.

def duplicate_encode(word):
    lista = list(word)
    palavra_final = ""
    tamanho_lista = len(lista)

    for letra in lista:
        print(letra)
        x = 0
        for i in range(tamanho_lista):
            y = lista[i].upper()
            print(y)
            if letra.upper() == y:
                x += 1
               # print(x)
        if x > 1:
                palavra_final += ")"
        else:
                palavra_final += "("
    print(palavra_final)


duplicate_encode("")
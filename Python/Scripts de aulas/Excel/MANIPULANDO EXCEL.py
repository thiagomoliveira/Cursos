# Importando a biblioteca pandas

import pandas as pd

# Abrindo o arquivo e colocando em uma variável

excel = pd.read_excel("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/exemplo.xlsx")

# Explorando funções

print(excel.info())
print(excel.head(3))
print(excel.columns)
print(excel["quantidade"])  # Nome da coluna
excel["total"] = excel["preco"] * excel["quantidade"]
excel["Soma acumulada"] = excel["total"].cumsum()

excel.to_excel("tabela.xls")
print(excel)


import pandas as pd

df = pd.read_excel("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/Estudos/Python/Scripts de aulas/arquivo.xlsx")

df = pd.read_excel("arquivo.xlsx")

df = pd.read_excel("arquivo.xlsx")

df.dropna(subset=["municipio"])

df.to_excel("tabela.xls")

pd.DataFrame(df.groupby(["data", "estado"]).sum()["obtidosAcumulado"])

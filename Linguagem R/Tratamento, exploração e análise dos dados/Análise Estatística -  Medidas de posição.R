

# Abrindo o arquivo e importando pacotes
library("dplyr")
install.packages("rstatix")
library("rstatix")

setwd("C:/Users/thiago.oliveira/OneDrive/�rea de Trabalho/Estudos/Linguagem R/Tratamento, explora��o e an�lise dos dados/dados-covid-sp-master/data")

covid_sp_tratado <- read.csv2("covid_sp_tratado.csv", sep ="," )

# Verificando tipagem das colunas

glimpse(covid_sp_tratado)

# Alterando a tipagem das colunas

covid_sp_tratado$data <- as.Date(covid_sp_tratado$data, format = '%Y-%m-%d')

covid_sp_tratado$idoso <- as.numeric(covid_sp_tratado$idoso)

# Excluindo coluna idoso com tipagem "errada" e renomeando a que ficou

covid_sp_tratado <- select(covid_sp_tratado, -c(18))

covid_sp_tratado <- rename(covid_sp_tratado, porcentagem_idoso = idoso)

# Criando tabelas com filtro em munic�pio, 
# arrumando erros na �rea e criando coluna "dens_demografica""

covid_campinas <- covid_sp_tratado %>% filter(municipio == "Campinas")

covid_campinas["area"] <- covid_campinas$area / 100

covid_campinas["dens_demografica"] <- covid_campinas$pop / covid_campinas$area

covid_guarulhos <- covid_sp_tratado[which(covid_sp_tratado$municipio =="Guarulhos"),]

covid_guarulhos["area"] <- covid_guarulhos$area / 100

covid_guarulhos["dens_demografica"] <- covid_guarulhos$pop / covid_guarulhos$area


### AN�LISE ESTAT�ST�CAS

# M�dia

mean(covid_campinas$obitos_novos)
mean(covid_campinas$casos_novos)

# Summarise_at -> Par�metros: tabela, vari�veis e fun��o
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), mean)

mean(covid_guarulhos$obitos_novos)
mean(covid_guarulhos$casos_novos)

# M�dia m�vel

plot(covid_campinas$data, covid_campinas$casos_mm7d, title("M�DIA M�VEL"), col = "red")
plot(covid_campinas$data, covid_campinas$casos_mm7d, title("M�DIA M�VEL"), col = "purple")

# Mediana (regi�o central)

median(covid_campinas$obitos_novos)
median(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), median)

median(covid_guarulhos$obitos_novos)
median(covid_guarulhos$casos_novos)

#moda

#criando uma fun��o

moda <- function(m){
  valor_unico <- unique(m) # busca valor �nico para coluna
  valor_unico[which.max(tabulate(match(m, valor_unico)))]
  #contabilizar quantas vezes o valor �nico aparece e buscar maior valor
}

moda(covid_campinas$obitos_novos)
moda(covid_campinas$casos_novos)

summarise_at(covid_campinas, vars(obitos_novos, casos_novos), moda)

moda(covid_guarulhos$obitos_novos)
moda(covid_guarulhos$casos_novos)


covid_julho_campinas <- covid_campinas %>% filter(mes == 7)
moda(covid_julho_campinas$obitos_novos)
moda(covid_julho_campinas$casos_novos)
summarise_at(covid_julho_campinas, vars(obitos_novos, casos_novos ), moda)

mean(covid_julho_campinas$obitos_novos)
mean(covid_julho_campinas$casos_novos)

# Histograma

hist(covid_julho_campinas$obitos_novos, col="blue")
hist(covid_julho_campinas$casos_novos, col="red")

hist(covid_campinas$obitos_novos, col="blue")
hist(covid_campinas$casos_novos, col="red")

hist(covid_guarulhos$obitos_novos, col="yellow")
hist(covid_guarulhos$casos_novos, col="blue")


### AULA COME�A AQUI ###

# Medidas de posi��o

# M�nimo
min(covid_campinas$obitos_novos)
min(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), min)

# M�ximo
max(covid_campinas$obitos_novos)
max(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), max)

# Amplitude total
range(covid_campinas$obitos_novos)
range(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos),range)

# Quartis
quantile(covid_campinas$obitos_novos)
quantile(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos),quantile)

# Amplitude Interquartil #Distancia do quartil 1 at� o 3
IQR(covid_campinas$obitos_novos)
IQR(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos),IQR)




# Abrindo o arquivo e importando pacotes
library("dplyr")
install.packages("rstatix")
library("rstatix")

setwd("C:/Users/thiago.oliveira/OneDrive/Área de Trabalho/Estudos/Linguagem R/Tratamento, exploração e análise dos dados/dados-covid-sp-master/data")

covid_sp_tratado <- read.csv2("covid_sp_tratado.csv", sep ="," )

# Verificando tipagem das colunas

glimpse(covid_sp_tratado)

# Alterando a tipagem das colunas

covid_sp_tratado$data <- as.Date(covid_sp_tratado$data, format = '%Y-%m-%d')

covid_sp_tratado$idoso <- as.numeric(covid_sp_tratado$idoso)

# Excluindo coluna idoso com tipagem "errada" e renomeando a que ficou

covid_sp_tratado <- select(covid_sp_tratado, -c(18))

covid_sp_tratado <- rename(covid_sp_tratado, porcentagem_idoso = idoso)

# Criando tabelas com filtro em município, 
# arrumando erros na área e criando coluna "dens_demografica""

covid_campinas <- covid_sp_tratado %>% filter(municipio == "Campinas")

covid_campinas["area"] <- covid_campinas$area / 100

covid_campinas["dens_demografica"] <- covid_campinas$pop / covid_campinas$area

covid_guarulhos <- covid_sp_tratado[which(covid_sp_tratado$municipio =="Guarulhos"),]

covid_guarulhos["area"] <- covid_guarulhos$area / 100

covid_guarulhos["dens_demografica"] <- covid_guarulhos$pop / covid_guarulhos$area


### ANÁLISE ESTATÍSTÍCAS

# Média

mean(covid_campinas$obitos_novos)
mean(covid_campinas$casos_novos)

# Summarise_at -> Parâmetros: tabela, variáveis e função
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), mean)

mean(covid_guarulhos$obitos_novos)
mean(covid_guarulhos$casos_novos)

# Média móvel

plot(covid_campinas$data, covid_campinas$casos_mm7d, title("MÉDIA MÓVEL"), col = "red")
plot(covid_campinas$data, covid_campinas$casos_mm7d, title("MÉDIA MÓVEL"), col = "purple")

# Mediana (região central)

median(covid_campinas$obitos_novos)
median(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), median)

median(covid_guarulhos$obitos_novos)
median(covid_guarulhos$casos_novos)

#moda

#criando uma função

moda <- function(m){
  valor_unico <- unique(m) # busca valor único para coluna
  valor_unico[which.max(tabulate(match(m, valor_unico)))]
  #contabilizar quantas vezes o valor único aparece e buscar maior valor
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


# Medidas de posição

# Mínimo
min(covid_campinas$obitos_novos)
min(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos), min)

# Máximo
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

# Amplitude Interquartil #Distancia do quartil 1 até o 3
IQR(covid_campinas$obitos_novos)
IQR(covid_campinas$casos_novos)
summarise_at(covid_campinas, vars(obitos_novos, casos_novos),IQR)


summary(covid_campinas$obitos_novos)
summary(covid_campinas$casos_novos)

# Box Plot

summary(covid_julho_campinas$obitos_novos)
boxplot(covid_julho_campinas$obitos_novos)

summary(covid_julho_campinas$casos_novos)
boxplot(covid_julho_campinas$casos_novos)

summary(covid_campinas$casos_novos)
boxplot(covid_campinas$casos_novos)
# Esse caso mostra 3 valores outliers

summary(covid_guarulhos$casos_novos)
boxplot(covid_guarulhos$casos_novos)

# Tratamento de outliers

covid_guarulhos %>% identify_outliers(casos_novos)
outliers <- c(boxplot.stats(covid_guarulhos$casos_novos)$out)
covid_guarulhos_sem_outliers <- covid_guarulhos[-c(which(covid_guarulhos$casos_novos %in% outliers)), ]
boxplot(covid_guarulhos_sem_outliers$casos_novos)

# Excluindo alguns outliers
covid_campinas %>% identify_outliers(casos_novos)
covid_campinas_sem_outliers <- covid_campinas %>% filter(data != "2020-06-19", data != "2020-07-22")
boxplot(covid_campinas_sem_outliers$casos_novos)

### AULA COMEÇA AQUI ###

# Medidas de dispersão 

# Variância
var(covid_campinas$obitos_novos)
var(covid_campinas$casos_novos)

var(covid_guarulhos$obitos_novos)
var(covid_guarulhos$casos_novos)

# desvio padrão
sd(covid_campinas$obitos_novos)
sd(covid_campinas$casos_novos)

sd(covid_guarulhos$obitos_novos)
sd(covid_guarulhos$casos_novos)


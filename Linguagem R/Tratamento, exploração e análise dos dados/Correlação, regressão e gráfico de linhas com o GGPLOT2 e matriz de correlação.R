

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

# Medidas de dispers�o 

# Vari�ncia
var(covid_campinas$obitos_novos)
var(covid_campinas$casos_novos)

var(covid_guarulhos$obitos_novos)
var(covid_guarulhos$casos_novos)

# desvio padr�o
sd(covid_campinas$obitos_novos)
sd(covid_campinas$casos_novos)

sd(covid_guarulhos$obitos_novos)
sd(covid_guarulhos$casos_novos)

# Testes de normalidade

# Existem 4 testes de normalidade principais (num�ricos)
# e dois testes gr�ficos

# Shapiro-wilk (limite de 5000 amostras)
# Anderson-Darling
# Kolmogorov-Smirnov
# Cramer-Von Mises
# Histograma
# QQPlot

# N�vel de signific�ncia de 5% ou n�vel de confian�a de 95%:
# Quando o par�metro p > 0,05 (distribui��o normal)

install.packages("nortest")
library(nortest)

# Histograma
hist(covid_campinas$casos_novos, probability = T, col="blue")
lines(density(covid_campinas$casos_novos), col="red")

# QQPLOT (Gr�fico de distribui��o normal)
qqnorm(covid_campinas$casos_novos)
qqline(covid_campinas$casos_novos)

# SHapiro-Wilk
shapiro.test(covid_campinas$casos_novos)

# Anderson-Darling
ad.test(covid_campinas$casos_novos)

# Kolmorov-Smirnov 
ks.test(covid_campinas$casos_novos, pnorm) # Em desuso, usar abaixo
lillie.test(covid_campinas$casos_novos)

# Cramer-von Mises
cvm.test(covid_campinas$casos_novos)

# COrrela��o linear

# Method: "pearson" para dados param�tricos(Normalidade e homocedasticidade)
#         "spearman" (volume grande de dados n�o param�tricos)
#         "kendall" (volume pequeno de dados n�o param�tricos)

plot(covid_campinas$casos, covid_campinas$obitos)
cor(covid_campinas$casos, covid_campinas$obitos, method ="spearman")

regressao <- lm(formula = obitos ~ casos, data = covid_campinas)
regressao$coefficients
summary(regressao)


### AULA COME�A AQUI ###

library(ggplot2)
install.packages("ggpubr")
library(ggpubr)

ggplot(data = covid_campinas, mapping = aes(x = casos, y = obitos)) +
    geom_point()+
    geom_smooth(method = "lm", col = "red")+
    stat_regline_equation(aes(label = paste(..eq.label..,..adj.rr.label..,
                                            sep= "*plain(\" ,  \")~~")), label.x = 15000,
                              label.y=1800) +
    theme_gray()

install.packages("corrplot")
library(corrplot)

# Daqui pra frente todos dados devem ser numericos pra rodar, portanto eu converti

library(tidyr)

covid_campinas <- as_tibble(covid_campinas)
covid_campinas_analise <- covid_campinas[5:13] %>% mutate_all(as.numeric)

matriz_corr <- cor(covid_campinas_analise, method="spearman")
View(matriz_corr)

corrplot(matriz_corr, method= "color")
corrplot(matriz_corr, method = "color",
         type = "full", order = "original",
         addCoef.col = "black",
         tl.col = "black", tl.srt = 45)

covid_cidades <- covid_sp_tratado %>% filter (municipio %in% c("Campinas", "Guarulhos", "Sorocaba"))

covid_cidades <- as_tibble(covid_cidades)
covid_cidades_analise <- covid_cidades[2:13] %>% mutate_all(as.numeric)
covid_cidades_analise["municipio"] <- covid_cidades$municipio

ggplot(covid_cidades_analise, aes(x = casos, y = obitos, color = municipio)) +
  geom_line()+
  labs(title = "Evolu��o dos �bitos em fun��o dos casos de COVID",
       x = "Casos",
       y = "�bitos") +
  theme_classic()
str(covid_cidades_analise)


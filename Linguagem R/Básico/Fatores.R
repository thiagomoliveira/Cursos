# facilita para saber a quantidade de cada categoria
# Exemplo: Masculino e feminino

escolaridade <- c("Fundamental", "M�dio", "Superior", "Fundamental", "M�dio", "Superior")

escolaridade_fator <- as.factor(escolaridade) # N�veis

summary(escolaridade)

summary(escolaridade_fator) # Quantifica cada n�vel

table(escolaridade)

tensao_casas <- c(110, 220, 220, 110, 220, 110, 110, 220)

summary(tensao_casas) # Para n�meros aparece v�rios elementos

tensao_casas_fator <- as.factor(tensao_casas)

summary(tensao_casas_fator) # Quantifica cada n�vel

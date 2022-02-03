
x <- 1

if (x<10){
  print("x é menor que 10")
} else {
  print('x é maior ou igual a 10')
}

y <- 10

if (y<10){
  print("é menor")
} else if(y == 10){
   print("é igual")
}else{
  ("é maior")
}

w <- 12
ifelse(w %% 2 == 0, "par", "impar")

nota <- 6
if (nota >=6){
  print("aprovado")
}else if(nota>=5 & nota<6){
  print("Recuperação")
}else{
  print("Reprovado")
}

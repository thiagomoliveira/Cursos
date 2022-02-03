maior <- function(x,y){
  if(x<y){
    return(y)
  }else{
    return(x)
  }
}
maior(3,5)

pitagoras = function(cat1,cat2,hip){
  if(hip =="?"){
    sqrt(cat1**2+cat2**2)
  }else if(cat1 == "?"){
    sqrt(hip**2 - cat2**2)
  }else{
    sqrt(hip**2-cat1**2)
  }
}

pitagoras(6,8,"?")

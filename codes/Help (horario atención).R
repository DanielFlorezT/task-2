
#### Limpiar la consola y el entorno
cat("\f")
rm(list=ls())
options("scipen"=100, "digits"=4) # Forzar a R a no usar e+

#### Establecer directorio de trabajo
setwd("~/Dropbox/teaching/Taller de R/uniandes_2020_2/Task/task-2 answer oficial") # Eduard
getwd()

#### Librerias
paquetes = c('tidyverse','haven')
sapply(paquetes,require,character.only=T) 

#### Crear un vector con los nombres de los archivos
meses = list.files('data/orignal/2019/') %>% paste0('data/orignal/2019/',.,'/')
files = lapply(1:length(meses),function(x) list.files(meses[x]) %>% paste0(meses[x],.))  %>% unlist()
files

#### Funcion que lee los archivos
f_read = function(path){
         data = read.csv(file = path , sep = ';')
         colnames(data) = tolower(colnames(data))
         return(data)
}

#### Aplicar la funcion
lista_archivos = files[c(grep('Cabecera',files),grep('Resto',files))] %>% 
                  .[c(grep('Caracter',.),grep('Desocupados',.),grep('Inactivos',.),grep('Ocupados',.),grep('Fuerza',.))]

lista_data = lapply(lista_archivos, function(x) f_read(path = x))

#### Crear objetos por modulo
caracte_u = lista_data[1:12] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 1)
caracte_r = lista_data[13:24] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 0)
caracte = plyr::rbind.fill(caracte_u,caracte_r)

desocupado = plyr::rbind.fill(lista_data[25:36] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 1),
                           lista_data[37:48] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 0))

inactivo = plyr::rbind.fill(lista_data[49:60] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 1),
                           lista_data[61:72] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 0))

ocupado = plyr::rbind.fill(lista_data[73:84] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 1),
                           lista_data[85:96] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 0))

fuerza = plyr::rbind.fill(lista_data[97:108] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 1),
                          lista_data[109:120] %>% data.table::rbindlist(use.names = T,fill = T) %>% mutate(urbano = 0))




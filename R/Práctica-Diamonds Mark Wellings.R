############################ ANALISIS ESTADISTICO - Master BI y BD  ###############################

# Hacer uso del dataset "diamonds" que contendra el precio (entre otras variables interesantes) de unos 54.000 diamantes.
#
# Objetivo : realizar distintos tipos de anÃ¡lisis estadÃ­stico de sus variables para intentar
# averiguar algÃºn tipo de comportamiento oculto aparentemente en los datos. 
#
# Para ello os marco los siguientes pasos: tipos de variables, medidas de posiciÃ³n central, medidas de dispersiÃ³n, 
# distribuciÃ³n y relaciÃ³n entre ellas, mÃ¡s anÃ¡lisis de regresiÃ³n
#
# Los diferentes indicadores presentes en el dataset "diamonds" son los siguientes:
# price: Precio en dolares americanos
# carat: peso del diamante
# cut: calidad del corte (Fair, Good, Very Good, Premium, Ideal)
# colour: color del diamante (desde D el mejor hasta J el peor)
# clarity: mide como de claro es el diamante (desde el peor I1, SI2, SI1, VS2, VS1, VVS2, VVS1, hasta el mejor IF)
# x: longitud en mm 
# y: ancho en  mm 
# z: profundidad en mm 
# depth: porcentaje total de profundidad 
# table: anchura de la parte superior de diamante con relación al punto más ancho 


# Responde cada bloque cubriendo al menos lo indicado:
#####################################################################################

# 1: Muestra representativa
# Selecciona una muestra representativa para "cut"

library(ggplot2)
dt<-as.data.frame(diamonds)

head(dt)
attach(dt)

ncol(dt)
nrow(dt)

set.seed(1)
dt_cut <- dt$cut
head(dt_cut)
dt_cut
# Se usa un 20% para sacar una muestra representative de la columna "cut", para no sacar valores iguales,
# se usa replace FALSE.
muestra <- sample(dt_cut,nrow(dt)*0.20,replace = F)
summary(muestra)
head(muestra)
##########
#2: Análisis de las variables
# Análisis descriptivo de las variables: Tipo de variable, distribución y representación
# Detección de casos atípicos y su tratamiento

##Tipo de variable
# price: variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
#DISTRIBUCION NORMAL
# carat: variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
#DISTRIBUCION NORMAL
# cut: variable cualitativa ordinal ->  puede tomar distintos valores ordenados siguiendo una escala establecida
#DISTRIBUCION NORMAL
# colour: variable cualitativa nominal -> no pueden ser sometidos a un criterio de orden
#DISTRIBUCION NORMAL
# clarity: variable cualitativa ordinal ->  puede tomar distintos valores ordenados siguiendo una escala establecida
#DISTRIBUCION NORMAL
# x:  variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
# y:  variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
# z:  variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
# depth:  variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo
# table: variable cuantitativa continua -> puede adquirir cualquier valor dentro de un intervalo

 

##REPRESENTACION
#Variables cuantitativas representadas por histograma y boxplot
#Variables cualitativas representadas por diagrama de baras

summary(dt$price)
hist(dt$price)
boxplot(dt$price)

summary(dt$carat)
hist(dt$carat)
boxplot(dt$carat)

summary(dt$color)
barplot(table(dt$color), main = "Color distribucion", xlab="Numero of Colors")

summary(dt$cut)
barplot(table(dt$cut), main = "Cut distribucion", xlab="Numero of Cuts")

summary(dt$color)
barplot(table(dt$color), main = "Color distribucion", xlab="Numero of Colors")

summary(dt$clarity)
barplot(table(dt$clarity), main = "Clarity distribucion", xlab="Numero of Clarity")

summary(dt$x)
hist(dt$x)
boxplot(dt$x)

summary(dt$y)
hist(dt$y)
boxplot(dt$y)

summary(dt$z)
hist(dt$z)
boxplot(dt$z)

summary(dt$depth)
hist(dt$depth)
boxplot(dt$depth)

summary(dt$table)
hist(dt$table)
boxplot(dt$table)

# Detección de casos atípicos y su tratamiento
##Cualquier valor fuera del intervalo (Q3 + 1.5 RIC, Q1 - 1.5 RIC) se considerará valor atípico 
### RIC = Rango inter cuartilico
### Existe la posibilidad de encontrar outliers con una funcion dentro de "boxplot". Ejemplo con carat:
test <- dt$carat
boxplot(test)
myboxplot <- boxplot(test)
unwanted <- myboxplot$out
unwanted
### unwanted muestra todos los valores atipicos (1889)

### Con la siguiente funcion tambien se puede encontrar outlier y quitarlos del conjunto

test <- dt$carat
FindOutliers <- function(data) {
  lowerq = quantile(data)[2]
  upperq = quantile(data)[4]
  iqr = upperq - lowerq #
  # identificar outliers con RIC 1.5
  extreme.threshold.upper = (iqr * 1.5) + upperq
  extreme.threshold.lower = lowerq - (iqr * 1.5)
  result <- which(data > extreme.threshold.upper | data < extreme.threshold.lower)
}

# usar funcion para encontrar outliers
temp <- FindOutliers(test)

# quitar outliers
test <- test[-temp]

# mostrar datos sin outliers
boxplot(test)



# 3: Inferencia
# Calcula un intervalo de confianza para la media de "carat" y "depth"


##IC:Carat con un intervalo de confianza de 95%. La variable "carat" sigue una distribucion normal, por lo tanto el valor Z es 1.96:
##Se saca una muestra de 20.000 y se calcula mean y sd

set.seed(2)
dt_carat <- dt$carat
sample_carat <- sample(dt_carat,20000,replace = F)
mean_carat <- mean(sample_carat)
sd_carat <- sd(sample_carat)

## con esta formula se calucla el margen del error:  

error_carat <- 1.96 * (sd_carat / sqrt(20000))

## El intervalo de confianza se calulca restando y sumando el error del mean:

mean_carat + error_carat 
mean_carat - error_carat

##El intervalo de confianza para carat esta entre: 0.7924051 y 0.8055459 (error 5%)


##IC:Depth con un intervalo de confianza de 90%. La variable "depth" sigue una distribucion normal, por lo tanto el valor Z es 1.64 :
##Se saca una muestra de 20.000 y se calcula mean y sd

set.seed(3)
dt_depth <- dt$depth
sample_depth <- sample(dt_depth,20000,replace = F)
mean_depth <- mean(sample_depth)
sd_depth <- sd(sample_depth)

## con esta formula se calucla el margen del error: Za/2 * ??/???(n), es decir: 

error_depth <- 1.64 * (sd_depth / sqrt(20000))

## El intervalo de confianza se calulca restando y sumando el error del mean:

mean_depth + error_depth 
mean_depth - error_depth

##El intervalo de confianza para carat esta entre: 61.74092 y 61.77407 (error 10%)

# Formula un test de hipótesis
#Ho: media = 0.79 # media igual
#H1: media != 0.79 # media no igual
t.test(sample_carat, mu=0.79, conf.level = 0.95)
## p-value = 0.007424 < alpha=0.05 -> se rechaza H0. 

##OTRO METODO####

n=20000
mean_carat=0.7989755
sd_carat=0.4740779
mean(dt_carat)

# Contraste
Ho: media >= 0.79 #media mayor o igual
H1: media < 0.79 #media mayor o igual

# Estadístico
t= (0.7989755-0.7979397)/(0.4740779/sqrt(n))
t

# valor teórico 
qt(0.05,df=19999)
-qt(.95, df=19999)

# valor teórico < valor del experimento
# -1.64493 < 0.3089877
# No se rechaza Ho, admitimos como correcta la especificación.
######


# 4: Relaciones entre las variables
# Muestra las relaciones que existen entre variables 
# (dependencia, anova, correlación)

##ANOVA##
#Relacion entre carat y precio: 

dt_carat <- dt$carat
dt_precio <- as.numeric(dt$price)


Combined <- data.frame(cbind(dt_carat, dt_precio)) # combines the data into a single data set.
head(Combined) # shows spreadsheet like results
summary(Combined)  # min, median, mean, max

Stacked <- stack(Combined)
head(Stacked) #shows the table Stacked_Groups

Anova_Results <- aov(values ~ ind, data = Stacked) 
summary(Anova_Results) # shows Anova_Results
#El valor p es muy pequeno <2e-16 y mucho menos que 0.05, asi que hay dependencia entre precio y carat. MUY SIGNIFICATIVO

###Dependencia con chi quadrado, entre precio y cut##
cont <- table(dt$price, dt$cut)
head(cont)
chisq.test(cont)
## X-squared = 58970, df = 46404, p-value < 2.2e-16
#El valor p es muy pequeno <2e-16 y mucho menos que 0.05, asi que hay dependencia entre precio y carat. MUY SIGNIFICATIVO


##Correlacion##

# Se comprueba la correlacion entre carat (peso) y x,y,z , ya que las variables son continuas y cuantitativas

cor.test(dt$carat,dt$x)
# 0.9750942 hay una relacion fuerte entre ambos. La correlacion es menor que 1, eso quiere decir que es mas probable que baje el peso cuando la longitud baja que cuando sube. 
cor.test(dt$carat,dt$y)
# 0.9517222 hay una relacion fuerte entre ambos. La correlacion es menor que 1, eso quiere decir que es mas probable que baje el peso cuando el ancho baja que cuando sube.
cor.test(dt$carat,dt$z)
# 0.9533874 hay una relacion fuerte entre ambos. La correlacion es menor que 1, eso quiere decir que es mas probable que baje el peso cuando la profundidad baja que cuando sube.

#####

# 5: Análisis de regresión
# Formular un modelo de regresión y analiza los resultados
# Interpreta los coeficientes estandarizados de la regresión


##La variable dependiente sera el precio y se analiza su relacion con las variables independientes/predictoras:
#carat, cut . La regresion analiza como varia la variable dependiente cuando la variable predictora se modifica.  
#Ademas permite predecir la variable dependiente.

plot(price ~ carat, data=dt)

#h0 no hay relacion entre price y carat -> intercept 0 y slope inclinacion 0
mean.price <- mean(dt$price,na.rm=T)
abline(h=mean.price)

#usame lm para pintar una linea de regresion por los datos
model1=lm(price~carat,data=dt)
model1
abline(model1,col="red") # linea de regresion en rojo

plot(model1)
# si dibujamos el model1 se ve los fitted values que son los valores predichos del model, mientras los residuals son las desviaciones de los valores predichos. 
termplot(model1)
#Con termplot se muy bien la relacion linear entre precio y carat
summary(model1)
# Con summary en primer lugar se puede observar que los residuos no son distribuidos de manera symetrica por 0 (igual que en el segundo grafico de plot(model1))
# Ademas se ve que el valor p es muy pequeno, con lo cual el intercept y el slope (inclinacion) de carat es diferente de 0 con alta probabilidad.
#Los astericos dicen que las variables elegidas son buenas para predecir la variable precio
# Se puede rechazar h0. 

##REGRESION CON DOS VARIABLE INDEPENDIENTES##
#Se trata de mostrar la influencia de carat y ancho para price
plot(price ~ carat, data=dt)
plot(price ~ y, data=dt)

#h0 no hay relacion entre price y carat / ancho -> intercept 0 y slope inclinacion 0

# se muestra la influencia unida de carat y ancho para precio. Se ve la influencia de carat al precio condicionado por el y
coplot(price~carat|y,panel=panel.smooth,data=dt)

# El model muestra el precio en funcion de carat multiplicado por y
model2 <- lm(price~carat*y,dt)
plot(model2)
# se muestran las relaciones entre las variables
summary(model2)
# carat tiene una relacion positiva con precio (cuando y=0), se fija el valor de y
# ancho tiene una relacion negativa con precio (cuando carat=0), se fija el valor de carat
# combinando los dos valores se ve que hay una relacion positiva. Ya que el valor p es muy pequeno parece que hay una relacion fuerte entre las variables.
#la probalidad de que la inclinacion de carat:y(ancho) es 0 se muestra muy pequena, con lo cual hay influence al precio.
#Los astericos dicen que las variables elegidas son buenas para predecir la variable precio
######
# Muestra los residuos y analiza los resultados
attributes(model1)
attributes(model2)
head(model1$residuals)
head(model2$residuals)

# Analisis
summary(model1$residuals)
plot(model1)
# La desviacion de la linea de regresion es mas fuerte hacia el negativo (por debajo de 0)
# La distribucion de los residuos se aproxima a una normal
# No hay muchas desviacion entre los residuos y los fitted values, hay una relacion fuerte. 
# De todos modos se ve que la linea roja se aparte mas de los fitted values cuando los fitted values incrementan. 

summary(model2$residuals)
plot(model2)
# El comportamiento anadiendo una variable es muy parecido al del model1, incluso se ajusta mas, es decir los residuos/desviaciones son menos.  

######
# Aplica una transformación a la regresión y analiza los resultados.

## El motivo de una transformacion es que se incrementa el valor R^2, es decir reducir la varianza  
## y acercar los fitted values a la linea de regresion. Posibles transformacion:
## log de la variable dependiente y/o independiete
## la raiz de la variable dependiente y/o independiete

#La transformacion se llama model3, se empieza con la tranformacion log:


model3=lm(log(price)~log(carat),dt)
summary(model3)

plot(log(price) ~ log(carat), data=dt)
abline(model3,col="red") # linea de regresion en rojo
# Se observa que los residuos se ajustan mas a la linea de regresion.
# Comparando el model3 con el model1 se ve que el valor R^2 ha incrementado:
#
# La ecuacion de la regresion se transforma igual. 

#La transformacion se llama model4, se empieza con la tranformacion log:

model4=lm(sqrt(price)~sqrt(carat),dt)
summary(model4)

plot(sqrt(price) ~ sqrt(carat), data=dt)
abline(model4,col="red") # linea de regresion en rojo
# Se observa que los residuos se ajustan mas a la linea de regresion.
# La transformacion no favorece al ajuste tanto como el log. El valor de R^2 es menor que el del model3.

#####
coefficients(model1)
coefficients(model2)
## La influencia de ancho y carat al precio es positivo, incrementan lar variables 
## independientes incremente el precio tambien. Despues de la transformacion
## se oberserva una fuerte influencia de la variable indepentiente. 
## Por ejemplo 




